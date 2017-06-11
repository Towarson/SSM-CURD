package com.ssm.crud.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.util.StringUtil;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.EmployeeExample;
import com.ssm.crud.bean.EmployeeExample.Criteria;
import com.ssm.crud.dao.EmployeeMapper;
import com.ssm.crud.service.EmployeeService;
/**
 * 员工信息--->业务层实现类
 * @author 米向冲
 * @version 1.0
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 */
	public List<Employee> getAllEmps() {
		return this.employeeMapper.selectByExampleWithDept(null);
	}
	
	/**
	 * 保存员工
	 * @param employee
	 */
	@Transactional
	public void saveEmployee(Employee employee) {
		this.employeeMapper.insertSelective(employee);
	}
	
	/**
	 * 修改员工
	 * @param employee
	 */
	public void updateEmployee(Employee employee) {
		this.employeeMapper.updateByPrimaryKeySelective(employee);//根据员工ID,有选择的更新
	}
	
	/**
	 * 删除员工
	 * @param employee
	 */
	public void deleteEmployee(Integer id) {
		this.employeeMapper.deleteByPrimaryKey(id);//根据员工ID删除
	}
	
	/**
	 * 检查姓名是否存在
	 * @param employee
	 * @return
	 */
	public Map<String, Boolean> checkUser(Employee employee) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(employee.getEmpName());
		if(employee.getEmpId() != null){//修改时,与自己之外的进行比较
			criteria.andEmpIdNotEqualTo(employee.getEmpId());
		}
		boolean b = this.employeeMapper.countByExample(example)==0;//0:true,当前没有该姓名。
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("valid", b);
		return map;
	}
	
	/**
	 * 检查邮箱是否存在
	 * @param employee
	 * @return
	 */
	public Map<String, Boolean> checkEmail(Employee employee) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmailEqualTo(employee.getEmail());
		if(employee.getEmpId() != null){//修改时,与自己之外的进行比较
			criteria.andEmpIdNotEqualTo(employee.getEmpId());
		}
		boolean b = this.employeeMapper.countByExample(example)==0;//0:true,邮箱不存在。
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("valid", b);
		return map;
	}
	
	/**
	 * 根据ID,查询员工信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		return this.employeeMapper.selectByPrimaryKey(id);
	}
	
	
}
