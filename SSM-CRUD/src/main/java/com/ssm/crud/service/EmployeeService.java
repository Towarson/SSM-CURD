package com.ssm.crud.service;

import java.util.List;
import java.util.Map;

import com.ssm.crud.bean.Employee;
/**
 * 员工信息--->业务层接口
 * @author 米向冲
 * @version 1.0
 */
public interface EmployeeService {

	/**
	 * 分页查询列表数据
	 * @return
	 */
	List<Employee> getAllEmps();
	
	/**
	 * 保存员工
	 * @param employee
	 */
	void saveEmployee(Employee employee);
	
	/**
	 * 修改员工
	 * @param employee
	 */
	void updateEmployee(Employee employee);
	
	/**
	 * 删除员工
	 * @param employee
	 */
	void deleteEmployee(Integer id);
	
	/**
	 * 批量删除员工
	 * @param ids
	 */
	void deleteBatch(String ids);
	
	/**
	 * 检查姓名是否存在
	 * @param employee
	 * @return
	 */
	Map<String, Boolean> checkUser(Employee employee);

	/**
	 * 检查邮箱是否存在
	 * @param employee
	 */
	Map<String, Boolean> checkEmail(Employee employee);
	
	/**
	 * 根据ID,查询员工信息
	 * @param id
	 * @return
	 */
	Employee getEmp(Integer id);

}
