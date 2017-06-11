package com.ssm.crud.service;

import java.util.List;

import com.ssm.crud.bean.Department;

/**
 * 部门信息--->业务层接口
 * @author Towarson
 * @Date 2017年5月30日
 * @version 1.0
 */
public interface DepartmentService {

	List<Department> getDetps();

}
