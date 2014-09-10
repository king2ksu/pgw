<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>项目自动生成工具</title>
<link rel="stylesheet" type="text/css" href="css/themes/metro-blue/easyui.css">
<link rel="stylesheet" type="text/css" href="css/themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/themes/demo.css">
<style type="text/css">
        #fm{
            margin:0;
            padding:10px 30px;
        }
        .ftitle{
            font-size:14px;
            font-weight:bold;
            padding:5px 0;
            margin-bottom:10px;
            border-bottom:1px solid #ccc;
        }
        .fitem{
            margin-bottom:5px;
        }
        .fitem label{
            display:inline-block;
            width:80px;
        }
</style>
<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-validator-myextend.js"></script>
<script type="text/javascript" src="js/myExtends.js"></script>
<script type="text/javascript">

    var editIndex = undefined;
    function generate(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('生成确认','是否生成此项目文件？',function(r){
                    if (r){
                        $.post('generator/generate.do',{projectName:row.projectName},function(result){
                            if (result == null || result == ''){
                            	$.messager.show({    
                                    title: '<spring:message code="operate_result_title"/>',
                                    msg: '<spring:message code="success_desc"/>'
                                });
                            } else {
                                $.messager.show({    // show error message
                                    title: '<spring:message code="operate_result_title"/>',
                                    msg: result
                                });
                            }
                        },'json');
                    }
                });
            }
    }
    
    function add(){
    	$('#dlg').dialog('open').dialog('setTitle','<spring:message code="add_project"/>');
        $('#fm').form('clear');
    }
    
    function save(){
    	$('#fm').form('submit',{
            url: 'systemconf/add.do',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                //var result = eval('('+result+')');
                if (result != null && result != ''){
                    $.messager.show({
                        title: '<spring:message code="operate_result_title"/>',
                        msg: result
                    });
                } else {
                	$.messager.show({
                	    title: '<spring:message code="operate_result_title"/>',
                        msg: '<spring:message code="success_desc"/>'
                	});
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the user data
                }
            }
        });
    }
    
    
    function mod(){
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $('#dlg3').dialog('open').dialog('setTitle','<spring:message code="mod_project"/>');
            $('#fm1').form('load',row);
        }
    }
    
    function modSave(){
    	$('#fm1').form('submit',{
            url: 'systemconf/mod.do',
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                //var result = eval('('+result+')');
                if (result != null && result != ''){
                    $.messager.show({
                        title: '<spring:message code="operate_result_title"/>',
                        msg: result
                    });
                } else {
                	$.messager.show({
                	    title: '<spring:message code="operate_result_title"/>',
                        msg: '<spring:message code="success_desc"/>'
                	});
                    $('#dlg3').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the user data
                }
            }
        });
    }
    
    function del(){
    	var row = $('#dg').datagrid('getSelected');
        if (row){
            $.messager.confirm('删除确认','是否删除此项目配置？',function(r){
                if (r){
                    $.post('systemconf/del.do',{names:row.projectName},function(result){
                        if (result == null || result == ''){
                        	$.messager.show({    
                                title: '<spring:message code="operate_result_title"/>',
                                msg: '<spring:message code="success_desc"/>'
                            });
                        	$('#dg').datagrid("reload");
                        } else {
                            $.messager.show({    // show error message
                                title: '<spring:message code="operate_result_title"/>',
                                msg: result
                            });
                        }
                    },'json');
                }
            });
        }
    }
    
    function appendTable(){
		if (endEditingTable()){
			$('#dg2').datagrid('appendRow',{prefix:'0',status:'1'});
			editIndex = $('#dg2').datagrid('getRows').length-1;
			$('#dg2').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
		}
	}
    
    function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg1').datagrid('validateRow', editIndex)){
			var ed = $('#dg1').datagrid('getEditor', {index:editIndex,field:'status'});
			var statusName = $(ed.target).combobox('getText');
			var statusValue = $(ed.target).combobox('getValue');
			$('#dg1').datagrid('getRows')[editIndex]['statusName'] = statusName;
			$('#dg1').datagrid('getRows')[editIndex]['status'] = statusValue;
			$('#dg1').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
    
    function endEditingTable(){

		if (editIndex == undefined){return true}
		if ($('#dg2').datagrid('validateRow', editIndex)){
			var prefixed = $('#dg2').datagrid('getEditor', {index:editIndex,field:'prefix'});
			var statused = $('#dg2').datagrid('getEditor', {index:editIndex,field:'status'});
			var prefixName = $(prefixed.target).combobox('getText');
			var statusName = $(statused.target).combobox('getText');
			$('#dg2').datagrid('getRows')[editIndex]['prefixName'] = prefixName;
			$('#dg2').datagrid('getRows')[editIndex]['statusName'] = statusName;
			$('#dg2').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
   
    
    function removeit(){
        if (editIndex == undefined){return}
        $('#dg1').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
        editIndex = undefined;
    }
    
    function removeitTable(){
        if (editIndex == undefined){return}
        $('#dg2').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
        editIndex = undefined;
    }
    
    function editTemplateList(){
    	editIndex = undefined;
    	var row = $('#dg').datagrid('getSelected');
        if (row){
        	$('#dg1').datagrid('loadData',{total:0,rows:[]});
        	$('#dlg1').dialog('open').dialog('setTitle','<spring:message code="edit_template_list"/>');
        	$('#dg1').datagrid({url:'systemconf/getTemplateList.do?projectName='+row.projectName+'&templatePath='+row.templatePath});
        }
    }
    
    function editTableList(){
    	editIndex = undefined;
    	var row = $('#dg').datagrid('getSelected');
        if (row){
        	$('#dg2').datagrid('loadData',{total:0,rows:[]});
        	$('#dlg2').dialog('open').dialog('setTitle','<spring:message code="edit_table_list"/>');
        	$('#dg2').datagrid({url:'systemconf/getTableList.do?projectName='+row.projectName});
        }
    }
    
    function onClickRow(index){
        if (editIndex != index){
            if (endEditing()){
                $('#dg1').datagrid('selectRow', index).datagrid('beginEdit', index);
                editIndex = index;
            } else {
                $('#dg1').datagrid('selectRow', editIndex);
            }
        }
    }
    
    function onClickRow2(index){
        if (editIndex != index){
            if (endEditingTable()){
                $('#dg2').datagrid('selectRow', index).datagrid('beginEdit', index);
                editIndex = index;
            } else {
                $('#dg2').datagrid('selectRow', editIndex);
            }
        }
    }
    
    function accept(){
		if (endEditing()){
			$('#dg2').datagrid('acceptChanges');
		}
	}
    
    function acceptTable(){
		if (endEditingTable()){
			$('#dg2').datagrid('acceptChanges');
		}
	}
    
    function saveTemplate(){
    	var jsonStr = '';
    	var rows = $('#dg1').datagrid('getRows');
    	if(rows != null && rows.length > 0){
    		jsonStr = "[";
    		for(var i = 0;i < rows.length; i++){
    			var row = rows[i];
    			jsonStr+="{";
    			jsonStr+="'templateName':'"+row.templateName+"',";
    			jsonStr+="'fileName':'"+row.fileName+"',";
    			var filePath = row.filePath;
    			if(filePath != null){
    			    filePath = filePath.replace(/\\/g, "\\\\" );
    			}
    			jsonStr+="'filePath':'"+filePath+"',";
    			jsonStr+="'desc':'"+row.desc+"',";
    			jsonStr+="'status':'"+row.status+"'";
    			jsonStr+="}";
    			if(i < rows.length - 1){
    				jsonStr+=",";
    			}
    		}
    		jsonStr+="]";
    	}
    	var dgrow = $('#dg').datagrid('getSelected');
    	$.post('systemconf/saveTemplate.do',{projectName:dgrow.projectName,jsonStr:jsonStr},function(result){
            if (result == null || result == ''){
            	$.messager.show({    
                    title: '<spring:message code="operate_result_title"/>',
                    msg: '<spring:message code="success_desc"/>'
                });
            	editIndex = undefined;
            	$('#dg1').datagrid("reload");
            } else {
                $.messager.show({    // show error message
                    title: '<spring:message code="operate_result_title"/>',
                    msg: result
                });
            }
        },'json');
    	
    }
    
    function saveTable(){
    	var jsonStr = '';
    	var rows = $('#dg2').datagrid('getRows');
    	if(rows != null && rows.length > 0){
    		jsonStr = "[";
    		for(var i = 0;i < rows.length; i++){
    			var row = rows[i];
    			jsonStr+="{";
    			jsonStr+="'tableName':'"+row.tableName+"',";
    			jsonStr+="'prefix':'"+row.prefix+"',";
    			jsonStr+="'status':'"+row.status+"'";
    			jsonStr+="}";
    			if(i < rows.length - 1){
    				jsonStr+=",";
    			}
    		}
    		jsonStr+="]";
    	}
	
	    var dgrow = $('#dg').datagrid('getSelected');
	    $.post('systemconf/saveTable.do',{projectName:dgrow.projectName,jsonStr:jsonStr},function(result){
            if (result == null || result == ''){
        	    $.messager.show({    
                    title: '<spring:message code="operate_result_title"/>',
                    msg: '<spring:message code="success_desc"/>'
                });
        	    editIndex = undefined;
        	    $('#dg2').datagrid("reload");
            } else {
                $.messager.show({    // show error message
                    title: '<spring:message code="operate_result_title"/>',
                    msg: result
                });
            }
        });
    }
    
    function reload(){
    	$('#dg').datagrid("reload");
    }
    
    
</script>
</head>
<body>
	<h2><spring:message code="main_title"/></h2>
	<div class="demo-info">
		<div class="demo-tip icon-tip"></div>
		<div><spring:message code="main_title_desc"/></div>
	</div>
	<div style="margin: 10px 0;"></div>
	<div class="easyui-layout" style="width: 1280px; height: 800px;">
		<div data-options="region:'south',split:true" style="height: 50px;">
		    <span style="font-family:arial;">Copyright &copy;2014 KSU Studio</span>
		</div>
		<div data-options="region:'west',split:true" title="<spring:message code="left_menu_title"/>" style="width: 100px;">
		    <div title="<spring:message code="project_list"/>" data-options="selected:true" style="padding: 10px;"><spring:message code="project_list"/></div>
		</div>
		<div data-options="region:'center',title:'<spring:message code="project_list"/>',iconCls:'icon-ok'">
			<table id="dg" class="easyui-datagrid"
				data-options="url:'systemconf/getList.do',method:'post',border:false,singleSelect:true,fit:true,fitColumns:true,toolbar:'#tb',remoteSort:false,multiSort:true">
				<thead>
					<tr>
						<th data-options="field:'projectName',width:100,sortable:true" ><spring:message code="project_name"/></th>
						<th data-options="field:'displayName',width:100,sortable:true" ><spring:message code="project_display_name"/></th>
						<th data-options="field:'templatePath',align:'left',width:200"><spring:message code="template_path"/></th>
						<th data-options="field:'driverName',align:'left',width:200"><spring:message code="driver_name"/></th>
						<th data-options="field:'user',align:'left',width:100"><spring:message code="user"/></th>
						<th data-options="field:'password',align:'left',width:100"><spring:message code="password"/></th>
						<th data-options="field:'url',align:'left',width:300"><spring:message code="url"/></th>
					</tr>
				</thead>
			</table>
			<div id="tb" style="padding: 5px; height: auto">
				<div style="margin-bottom: 5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add();"></a> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="mod()"></a> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del();"></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="reload();"></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="generate();"><spring:message code="project_generate"/></a> 
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editTemplateList();"><spring:message code="edit_template_list"/></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editTableList();"><spring:message code="edit_table_list"/></a>  
				</div>

			</div>
			<div id="dlg" class="easyui-dialog" style="width:700px;height:410px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
               <div class="ftitle"><spring:message code="project_info"/></div>
               <form id="fm" method="post" novalidate>
                    <div class="fitem">
                        <label><spring:message code="project_name"/>:</label>
                        <input name="projectName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" validType="isNumberOr_Letter" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="project_display_name"/>:</label>
                        <input name="displayName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="template_path"/>:</label>
                        <input name="templatePath" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="output_path"/>:</label>
                        <input name="outputPath" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="driver_name"/>:</label>
                        <input name="driverName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="user"/>:</label>
                        <input name="user" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="password"/>:</label>
                        <input name="password" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="url"/>:</label>
                        <input name="url" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    
             </form>
          </div>
          <div id="dlg3" class="easyui-dialog" style="width:700px;height:410px;padding:10px 20px" closed="true" buttons="#dlg-buttons3">
               <div class="ftitle"><spring:message code="project_info"/></div>
               <form id="fm1" method="post" novalidate>
                    <div class="fitem">
                        <label><spring:message code="project_name"/>:</label>
                        <input name="projectName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px" readonly="readonly">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="project_display_name"/>:</label>
                        <input name="displayName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="template_path"/>:</label>
                        <input name="templatePath" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="output_path"/>:</label>
                        <input name="outputPath" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="driver_name"/>:</label>
                        <input name="driverName" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="user"/>:</label>
                        <input name="user" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="password"/>:</label>
                        <input name="password" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
                    <div class="fitem">
                        <label><spring:message code="url"/>:</label>
                        <input name="url" class="easyui-validatebox" missingMessage="<spring:message code="required"/>" required="true" style="width:450px">
                    </div>
             </form>
          </div>
        <div id="dlg1" class="easyui-dialog" style="width:1024px;height:600px;padding:10px 20px" closed="true" buttons="#dlg-buttons1">
        <div class="ftitle"><spring:message code="edit_template_list"/></div>
        <div data-options="region:'center',title:'<spring:message code="project_list"/>',iconCls:'icon-ok'">
			<table id="dg1" class="easyui-datagrid" data-options="iconCls: 'icon-edit',singleSelect: true,toolbar: '#tb1',method: 'post',remoteSort:false,multiSort:true,onClickRow: onClickRow,
			    rowStyler: function(index,row){
                    if (row.flag == 'add'){
                        return 'background-color:#006400;color:#fff;font-weight:bold;';
                    }else if(row.flag == 'delete'){
                        return 'background-color:#8b0000;color:#fff;font-weight:bold;';
                    }
                }">
				<thead>
                    <tr>
                       <th data-options="field:'templateName',width:200,sortable:true,align:'right',editor:{type:'validatebox',options:{missingMessage:'<spring:message code='required'/>',required:true}}"><spring:message code="template_name"/></th>
                       <th data-options="field:'fileName',width:230,sortable:true,align:'right',editor:{type:'validatebox',options:{missingMessage:'<spring:message code='required'/>',required:true}}"><spring:message code="template_file_name"/></th>
                       <th data-options="field:'filePath',width:230,align:'right',editor:'text'"><spring:message code="template_file_path"/></th>
                       <th data-options="field:'desc',width:230,align:'right',editor:'text'"><spring:message code="template_desc"/></th>
                       <th data-options="field:'status',width:50,sortable:true,align:'right',formatter:function(value,row){
                            return row.statusName;
                        },editor:{
                            type:'combobox',
                            options:{
                                valueField:'statusValue',
                                textField:'statusName',
                                url:'pages/status.json',
                                required:true
                            }
                        }"><spring:message code="status"/></th>
                   
                   </tr>
               </thead>
			</table>
		</div>
		</div>
        <div id="tb2" style="padding: 5px; height: auto">
				<div style="margin-bottom: 5px">
				    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendTable()"></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeitTable()"></a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="acceptTable()"></a>
				</div>
		</div>
		<div id="dlg2" class="easyui-dialog" style="width:800px;height:600px;padding:10px 20px" closed="true" buttons="#dlg-buttons2">
        <div class="ftitle"><spring:message code="edit_table_list"/></div>
        <div data-options="region:'center',title:'<spring:message code="project_list"/>',iconCls:'icon-ok'">
			<table id="dg2" class="easyui-datagrid" data-options="iconCls: 'icon-edit',singleSelect: true,toolbar: '#tb2',method: 'post',onClickRow: onClickRow2,remoteSort:false,multiSort:true">
				<thead>
                    <tr>
                       <th data-options="field:'tableName',width:300,sortable:true,align:'right',editor:{type:'validatebox',options:{required:true}}"><spring:message code="table_name"/></th>
                       <th data-options="field:'prefix',width:200,sortable:true,align:'right',formatter:function(value,row){
                            return row.prefixName;
                        },editor:{
                            type:'combobox',
                            options:{
                                valueField:'prefixValue',
                                textField:'prefixName',
                                url:'pages/prefix.json',
                                required:true
                            }
                        }"><spring:message code="table_prefix_name"/></th>
						
						
                       <th data-options="field:'status',width:200,align:'right',formatter:function(value,row){
                            return row.statusName;
                        },editor:{
                            type:'combobox',
                            options:{
                                valueField:'statusValue',
                                textField:'statusName',
                                url:'pages/status.json',
                                required:true
                            }
                        }"><spring:message code="status"/></th>
                   </tr>
               </thead>
			</table>
		</div>
		</div>
        <div id="dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save();"><spring:message code="save_button"/></a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"><spring:message code="cancel_button"/></a>
        </div>
        <div id="dlg-buttons1">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveTemplate();"><spring:message code="save_button"/></a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg1').dialog('close')"><spring:message code="cancel_button"/></a>
        </div>
        <div id="dlg-buttons2">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveTable();"><spring:message code="save_button"/></a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')"><spring:message code="cancel_button"/></a>
        </div>
        <div id="dlg-buttons3">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="modSave();"><spring:message code="save_button"/></a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg3').dialog('close')"><spring:message code="cancel_button"/></a>
        </div>
	</div>
</body>
<script type="text/javascript">
$('#dg').datagrid({
    onLoadSuccess: function (data) {
        $('#dg').datagrid('doCellTip', {
            onlyShowInterrupt: false,     //是否只有在文字被截断时才显示tip，默认值为false             
            position: 'bottom',   //tip的位置，可以为top,botom,right,left
            cls: { 'background-color': '#D1EEEE' },  //tip的样式
            delay: 100   //tip 响应时间
        });
        
    }
});
</script>
</html>