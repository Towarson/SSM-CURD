package com.ssm.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {
	
    private Integer empId;
    
    @Pattern(regexp="(^[a-zA-Z0-9_-]{4,15}$)|(^[\\u2E80-\\u9FFF]{2,6})",
    		 message="员工姓名只能是2-6位中文或4-15位英文和数字组合")
    private String empName;

    private String gender;
    
    @Email(message="邮箱格式不正确")
    private String email;

    private Integer dId;
    
    private Department department;
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email,
			Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
    
}