<#assign className = "${tableDTO.classNameNoPrefix}">    
    public static final String ${className?upper_case}_ADD_SUCCESS = "success|${className?lower_case}_0001";
	public static final String ${className?upper_case}_ADD_FAIL = "error|${className?lower_case}_0002";
	public static final String ${className?upper_case}_MOD_SUCCESS = "success|${className?lower_case}_0003";
	public static final String ${className?upper_case}_MOD_FAIL = "error|${className?lower_case}_0004";
	public static final String ${className?upper_case}_REPEAT_FAIL = "error|${className?lower_case}_0005";
	public static final String ${className?upper_case}_DEL_SUCCESS = "success|${className?lower_case}_0006";
	public static final String ${className?upper_case}_DEL_FAIL = "error|${className?lower_case}_0007";