package com.xxl.codegenerator.admin.core.util;

/**
 * string tool
 *
 * 临时的修改下  不改字符写法 ，按原来字符的显示
 *
 * @author xuxueli 2018-05-02 20:43:25
 */
public class StringUtils {

    /**
     * 首字母大写
     *
     * @param str
     * @return
     */
    public static String upperCaseFirst(String str) {
        //return str;
       return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    /**
     * 首字母小写
     *
     * @param str
     * @return
     */
    public static String lowerCaseFirst(String str) {
        return str;
        //return str.substring(0, 1).toLowerCase() + str.substring(1);
    }

    /**
     * 下划线，转换为驼峰式
     *
     * @param underscoreName
     * @return
     */
    public static String underlineToCamelCase(String underscoreName) {
        return underscoreName;
//        StringBuilder result = new StringBuilder();
//        if (underscoreName != null && underscoreName.trim().length() > 0) {
//            boolean flag = false;
//            for (int i = 0; i < underscoreName.length(); i++) {
//                char ch = underscoreName.charAt(i);
//                if ("_".charAt(0) == ch) {
//                    flag = true;
//                } else {
//                    if (flag) {
//                        result.append(Character.toUpperCase(ch));
//                        flag = false;
//                    } else {
//                        result.append(ch);
//                    }
//                }
//            }
//        }
//        return result.toString();
    }

}
