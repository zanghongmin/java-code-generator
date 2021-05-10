<#if ppname??>
package ${ppname}.service.DBService;
</#if>
import ${ppname}.core.PageList;
import ${ppname}.core.PageQuery;
import ${ppname}.core.ReturnT;
import ${ppname}.dao.${classInfo.className}Dao;
import ${ppname}.model.${classInfo.className};
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
/**
* ${classInfo.classComment}
* Created by zang on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@Service
public class ${classInfo.className}Service {

	@Resource
	private ${classInfo.className}Dao ${classInfo.className?uncap_first}Dao;
    //新增
	public ReturnT<String> insert(${classInfo.className} ${classInfo.className?uncap_first}) {
        if (${classInfo.className?uncap_first} == null) {
            return new ReturnT(ReturnT.FAIL_CODE, "必要参数缺失");
        }
        ${classInfo.className?uncap_first}Dao.insert(${classInfo.className?uncap_first});
        return ReturnT.SUCCESS;
    }
    //新增多条
    public ReturnT<String> insertMany(List<${classInfo.className}> ${classInfo.className?uncap_first}s) {
        if (${classInfo.className?uncap_first}s == null && ${classInfo.className?uncap_first}s.size()<=0) {
            return new ReturnT(ReturnT.FAIL_CODE, "必要参数缺失");
        }
        ${classInfo.className?uncap_first}Dao.insertMany(${classInfo.className?uncap_first}s);
        return ReturnT.SUCCESS;
    }
    //删除
    public ReturnT<String> delete(Integer id) {
        if (id == null) {
        return new ReturnT(ReturnT.FAIL_CODE, "必要参数缺失");
        }
        int ret = ${classInfo.className?uncap_first}Dao.delete(id);
        return ret>0?ReturnT.SUCCESS:ReturnT.FAIL;
    }
    //更新单条
    public ReturnT<String> update(${classInfo.className} ${classInfo.className?uncap_first}) {
        if (${classInfo.className?uncap_first} == null) {
            return new ReturnT(ReturnT.FAIL_CODE, "必要参数缺失");
        }
        int ret = ${classInfo.className?uncap_first}Dao.update(${classInfo.className?uncap_first});
        return ret>0?ReturnT.SUCCESS:ReturnT.FAIL;
    }
    //更新多条
    public ReturnT<String> updateMany(List<${classInfo.className}> ${classInfo.className?uncap_first}s) {
        if (${classInfo.className?uncap_first}s == null || ${classInfo.className?uncap_first}s.size()<=0) {
            return new ReturnT(ReturnT.FAIL_CODE, "必要参数缺失");
        }
        int ret = ${classInfo.className?uncap_first}Dao.batchUpdate(${classInfo.className?uncap_first}s);
        return ret>0?ReturnT.SUCCESS:ReturnT.FAIL;
    }
    //Load查询
    public ${classInfo.className} load(Integer id) {
        if (id == null) {
            return null;
        }
        return ${classInfo.className?uncap_first}Dao.load(id);
    }
    //分页查询
    public PageList<${classInfo.className}> pageList(${classInfo.className} ${classInfo.className?uncap_first}, int pagenum, int pagesize) {
        if (${classInfo.className?uncap_first} == null || pagenum<=0 || pagesize<=0) {
            PageList result = new PageList(pagenum,pagesize,0,null);
            return result;
        }
        PageQuery pageQuery = PageQuery.getPageQuery(pagenum,pagesize);
        List<${classInfo.className}> pageList = ${classInfo.className?uncap_first}Dao.pageList(${classInfo.className?uncap_first},pageQuery.getPageoffset(), pageQuery.getPagesize());
        int totalCount = ${classInfo.className?uncap_first}Dao.pageListCount(${classInfo.className?uncap_first});
        PageList result = new PageList(pagenum,pagesize,totalCount,pageList);
        return result;
    }
}
