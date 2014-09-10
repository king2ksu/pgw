package com.ksu.projectGeneratorWeb.util;

import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class MyUtils {

	public static Date stringToDate(String str) {
		if (str != null && !str.equals("")) {
			Date date = null;
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			try {
				date = format.parse(str);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return date;
		} else {
			return null;
		}

	}

	public static int stringToInt(String str) {
		return Integer.parseInt(str);
	}

	public static String dateToString(Date date) {
		if (date != null) {
			String str = null;
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			str = format.format(date);
			return str;
		} else {
			return null;
		}
	}
	
	public static String dateToStringNoTime(Date date) {
		if (date != null) {
			String str = null;
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			str = format.format(date);
			return str;
		} else {
			return null;
		}
	}

	public static String encryptMD5(String inStr) {

		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		char[] charArray = inStr.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];

		byte[] md5Bytes = md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();

		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}

		return hexValue.toString();
	}
	
	/** 
     * 生成32位编码 
     * @return string 
     */  
    public static String getUUID(){  
        String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");  
        return uuid;  
    } 

}
