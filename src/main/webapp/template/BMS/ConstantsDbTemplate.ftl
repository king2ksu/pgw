<#assign className = "${tableDTO.classNameNoPrefix}">
    public static final String ${className?upper_case}_SELECT = "${className?lower_case}.select";
	public static final String ${className?upper_case}_INSERT = "${className?lower_case}.insert";
	public static final String ${className?upper_case}_SELECT_REPEAT = "${className?lower_case}.selectRepeat";
	public static final String ${className?upper_case}_DELETE = "${className?lower_case}.delete";
	public static final String ${className?upper_case}_UPDATE = "${className?lower_case}.update";