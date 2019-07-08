package ${packgage}.controller;

import ${packgage}.core.ReturnT;
import ${packgage}.dto.TestRequest;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;

@Api(value = "测试API", description = "测试API")
@Controller
@RequestMapping("/api")
public class APIController {

    @ApiOperation(value = "测试API")
    @PostMapping(value="/test",produces = "application/json;charset=UTF-8")
    @ResponseBody
	public ReturnT<String> test(@Valid @ModelAttribute TestRequest testRequest){
		return ReturnT.SUCCESS;
	}

}