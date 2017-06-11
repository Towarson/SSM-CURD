package com.ssm.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.crud.bean.Employee;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.dao.EmployeeMapper;

/**
 * 测试Dao 层
 * @author Administrator
 * 推荐Spting的项目可以使用Spring的单元测试，可以自动注入我们需要的信息
 * 1、导入Spring test单元测试jar包
 * 2、@ContextConfiguration指定Spring配置文件的位置
 * 3、直接Autowired注入要是用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-context.xml"})
public class MapperTest {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	private SqlSession sqlSession;//批量的sqlSession
	
	@Test
	public void testInsertDept() {
/*		//1.创建IOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:spring-context.xml");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		//1.测试插入部门
//		this.departmentMapper.insertSelective(new Department(null,"开发部"));
//		this.departmentMapper.insertSelective(new Department(null,"产品部"));
//		this.departmentMapper.insertSelective(new Department(null,"测试部"));
//		this.departmentMapper.insertSelective(new Department(null,"销售部"));
		
		//2.测试员工
//		this.employeeMapper.insertSelective(new Employee(null,"Jack","M","Jack@gmail.com",1));
		
		//3.批量插入多个员工使用sqlSession
		long startTime = System.currentTimeMillis();
		EmployeeMapper mapper = this.sqlSession.getMapper(EmployeeMapper.class);//批量的mapper
		for (int i = 0; i < 1000; i++) {
			String empName = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,empName,"M",empName+"@gmail.com",1));
		}
		long endTime = System.currentTimeMillis();
		System.out.println("耗时："+(endTime-startTime)/1000 + "s");
	}
}
