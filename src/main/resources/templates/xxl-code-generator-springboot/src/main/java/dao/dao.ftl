package ${packgage}.dao;
import org.apache.ibatis.annotations.Param;
import ${packgage}.model.${classInfo.className};

import java.util.List;

/**
* ${classInfo.classComment}
*
* Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
public interface ${classInfo.className}Dao {

    /**
    * 新增
    */
    public int insert(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * 删除
    */
    public int delete(@Param("${classInfo.primaryKeyfieldName?uncap_first}") ${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first});

    /**
    * 更新
    */
    public int update(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * Load查询
    */
    public ${classInfo.className} load(@Param("${classInfo.primaryKeyfieldName?uncap_first}") ${classInfo.primaryKeyfieldClass} ${classInfo.primaryKeyfieldName?uncap_first});

    /**
    * 分页查询Data
    */
	public List<${classInfo.className}> pageList(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first},@Param("offset") int offset,
                                                 @Param("pagesize") int pagesize);

    /**
    * 分页查询Count
    */
    public int pageListCount(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first});

}
