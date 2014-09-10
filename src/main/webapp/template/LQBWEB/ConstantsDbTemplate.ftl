<#assign className = "${tableDTO.className}">
    public static final String ${tableDTO.tableName?upper_case}_SELECT = "${tableDTO.className}.select";
	public static final String ${tableDTO.tableName?upper_case}_INSERT = "${tableDTO.className}.insert";
	public static final String ${tableDTO.tableName?upper_case}_SELECT_REPEAT = "${tableDTO.className}.selectRepeat";
	public static final String ${tableDTO.tableName?upper_case}_DELETE = "${tableDTO.className}.delete";
	public static final String ${tableDTO.tableName?upper_case}_UPDATE = "${tableDTO.className}.update";
	public static final String ${tableDTO.tableName?upper_case}_SELECT_TOTAL_COUNT = "${tableDTO.className}.count";