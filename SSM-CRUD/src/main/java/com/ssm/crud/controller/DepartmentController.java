package com.ssm.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.DepartmentService;

/**
 * 部门信息--->控制层
 * @author Towarson
 * @Date 2017年5月30日
 * @version 1.0
 */
@RequestMapping("/dept")
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	public @ResponseBody Msg getDetps() {
		
		List<Department> list = this.departmentService.getDetps();
		
		return Msg.success().add("depts", list);
		
	}
}
