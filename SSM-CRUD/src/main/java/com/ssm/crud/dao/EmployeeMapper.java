package com.ssm.crud.dao;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
	
    long countByExample(EmployeeExample example);//根据条件计数

    int deleteByExample(EmployeeExample example);//根据条件删除

    int deleteByPrimaryKey(Integer empId);//根据主键删除

    int insert(Employee record);//保存

    int insertSelective(Employee record);//有条件的保存

    List<Employee> selectByExample(EmployeeExample example);//根据条件查询列表
    
    List<Employee> selectByExampleWithDept(EmployeeExample example);//根据条件查询列表(带部门信息)

    Employee selectByPrimaryKey(Integer empId);//根据主键查询员工
    
    Employee selectByPrimaryKeyWithDept(Integer empId);//根据主键查询员工(带部门信息)

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);//根据主键有条件的更新

    int updateByPrimaryKey(Employee record);//根据主键更新

}