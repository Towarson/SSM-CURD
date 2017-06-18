package com.ssm.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.EmployeeService;
/**
 * 员工信息--->控制层
 * @author 米向冲
 * @version 1.0
 */
@RequestMapping("/emp")
@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeservice;
	
	/**
	 *  查询所有员工（分页查询）
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNo",required=false,defaultValue="1") Integer pageNo,
										 @RequestParam(value="pageSize",required=false,defaultValue="5") Integer pageSize,
										 Model model) {
		PageHelper.startPage(pageNo,pageSize );
		//pageHelper紧跟着的查询方法，即为分页查询
		List< Employee> list = this.employeeservice.getAllEmps();
		//使用pageInfo将查询结果进行查询
		PageInfo<Employee> page = new PageInfo<Employee>(list,5);//5代表连续显示的页数为5
		model.addAttribute("pageInfo",page);
		return "emp/list";
	}
	
	/**
	 * 查询所有员工(分页查询),返回Json数据.
	 * @ResponseBody 起作用,需要引入Jackson包,将对象转化为json数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("/getWithJson")
	public @ResponseBody Msg getWithJson(@RequestParam(value="pageNo",required=false,defaultValue="1") Integer pageNo,
										 @RequestParam(value="pageSize",required=false,defaultValue="5") Integer pageSize) {
		PageHelper.startPage(pageNo,pageSize );
		//pageHelper紧跟着的查询方法，即为分页查询
		List<Employee> list = this.employeeservice.getAllEmps();
		//使用pageInfo将查询结果进行查询
		PageInfo<Employee> page = new PageInfo<Employee>(list,5);
		return Msg.success().add("pageInfo", page);//5代表连续显示的页数为5
	}
	
	/**
	 * 查询所有员工(分页查询),返回Json数据.
	 * @ResponseBody 起作用,需要引入Jackson包,将对象转化为json数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> empList(@RequestParam(value="pageNumber",required=false,defaultValue="1") Integer pageNum,
									 				@RequestParam(value="pageSize",required=false,defaultValue="5") Integer pageSize) {
		Map<String, Object> resultMap =new HashMap<String, Object>();
		PageHelper.startPage(pageNum,pageSize);
		//pageHelper紧跟着的查询方法，即为分页查询
		List<Employee> list = this.employeeservice.getAllEmps();
		//使用pageInfo将查询结果进行查询
		PageInfo<Employee> page = new PageInfo<Employee>(list,pageSize);
		resultMap.put("rows", page.getList());
		resultMap.put("total", page.getTotal());
		return resultMap;
	}
	
	/**
	 * 保存员工
	 * @param employee @Valid进行校验
	 * @param bindingResult 校验结果
	 * @return
	 */
	@RequestMapping(value="/",method=RequestMethod.POST)
	public @ResponseBody Msg saveEmployee(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {//绑定到对象失败后
			Map<String,Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();//获取到所有校验失败的项
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);//校验失败
		}else{
			this.employeeservice.saveEmployee(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 修改员工
	 * Tomcat:
	 * 		1.将请求体中的数据，封装成一个map.
	 * 		2.request.getParameter("empName")就会从这个map中取值
	 * 		3.SpringMVC封装POJO对象的时候,会把POJO中每个属性的值,
	 * 							request.getParameter("empName")
	 * @param employee @Valid进行校验
	 * @param bindingResult 校验结果
	 * @return
	 */
	@RequestMapping(value="/",method=RequestMethod.PUT)
	public @ResponseBody Msg updateEmployee(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {//绑定到对象失败后
			Map<String,Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();//获取到所有校验失败的项
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);//校验失败
		}else{
			this.employeeservice.updateEmployee(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 删除员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{ids}",method=RequestMethod.DELETE)
	public @ResponseBody Msg deleteEmployee(@PathVariable("ids") String ids) {
		if(ids.contains(",")) {
			this.employeeservice.deleteBatch(ids);//批量删除
		}else{
			this.employeeservice.deleteEmployee(Integer.parseInt(ids));//单个删除
		}
		return Msg.success();
	}
	
	/**
	 * 检查用户是否存在
	 * @param employee
	 */
	@RequestMapping(value="/checkUser")
	public @ResponseBody Map<String,Boolean> checkUser(Employee employee) {
		return this.employeeservice.checkUser(employee);
	}
	
	/**
	 * 检查邮箱是否存在
	 * @param employee
	 */
	@RequestMapping(value="/checkEmail")
	public @ResponseBody Map<String,Boolean> checkEmail(Employee employee){
		return this.employeeservice.checkEmail(employee);
        
	}
	
	/**
	 * 根据ID,查询员工信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public @ResponseBody Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = this.employeeservice.getEmp(id);
		return Msg.success().add("employee", employee);
	}
}
