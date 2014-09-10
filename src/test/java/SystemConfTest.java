
import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.ksu.projectGeneratorWeb.controller.SystemConfController;


@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations = "classpath:applicationContext.xml")
@Transactional 
public class SystemConfTest extends AbstractJUnit4SpringContextTests{

	@Resource
	private SystemConfController systemConfController;
	
	private MockHttpServletRequest request ;  
	private MockHttpServletResponse response ;  
	
	@Test
	public void test(){
		request = new MockHttpServletRequest();
		response = new MockHttpServletResponse(); 
		request.setCharacterEncoding("UTF-8");  
        saveTemplate();
	}

	private void saveTemplate() {
		String jsonStr = "[{'templateName':'1111','fileName':'aaaa','filePath':'bbbb','desc':'2222','status':'1'},{'templateName':'222','fileName':'cccc','filePath':'dddd','desc':'3333','status':'1'}]";
		systemConfController.saveTemplate("lqbweb", jsonStr);
	}
	

	
}
