package com.ssm.crud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.crud.bean.Department;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.service.DepartmentService;
/**
 * 部门信息--->业务层实现类
 * @author Towarson
 * @Date 2017年5月30日
 * @version 1.0
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDetps() {
		return this.departmentMapper.selectByExample(null);
	}
	
}
