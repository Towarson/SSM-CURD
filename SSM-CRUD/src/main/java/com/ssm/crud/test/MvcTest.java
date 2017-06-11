package com.ssm.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;

/**
 *  使用Spring的单元测试
 *  Spring4测试时需要用Servlet3.0以上版本 
 * @author 米向冲
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration//可以注入SpringMVC容器自己
@ContextConfiguration(locations={"classpath:spring-context.xml","classpath:springmvc.xml"})
public class MvcTest {
	
	@Autowired
	WebApplicationContext context;//注入SpringMVC的IOC

	MockMvc mockMvc;//虚拟的mvc请求，获取到处理结果
	
	@Before
	public void  initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception{
		//模拟请求并拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo","1")).andReturn();
		
		//请求成功后，请求域中会有pageInfo，去除pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo page = (PageInfo)request.getAttribute("pageInfo");
		System.out.println("当前页码：" + page.getPageNum()+"\n"+"总页码：" + page.getPages());
		System.out.println("总记录数："+page.getTotal());
		System.out.println("在页面上需要连续显示的页码：");
		int[] nums = page.getNavigatepageNums();
		for (int i : nums) {
			System.out.print("   "+i);
		}
		System.out.println();
		List<Employee> list = page.getList();
		for (Employee employee : list) {
			System.out.println("ID:"+employee.getEmpId()+"\t"+"员工姓名："+employee.getEmpName()+"\t"+"员工性别："+employee.getGender()+"\t"+"员工邮箱："+employee.getEmail());
		}
	}
}
