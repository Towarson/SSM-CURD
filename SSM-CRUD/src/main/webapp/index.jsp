<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
 		pageContext.setAttribute("path",request.getContextPath());
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<jsp:include page="/WEB-INF/pages/common/include.jsp"></jsp:include>
</head>
<body>
	<!-- 搭建显示页面-->
	<div class="container">
		<!-- 标题-->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--按钮-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button id="forAdd" class="btn btn-primary">新增</button>
				<button id="forDel" class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>员工姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!--显示分页信息 -->
		<div class="row">
			<!-- 分页的文字信息 -->
			<div id="page_info_area" class="col-md-6" ></div>
			<!-- 分页条信息 -->
			<div id="page_nav_area" class="col-md-6">

			</div>
		</div>
	</div>
	
	<!-- 新增模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel"></h4>
	      </div>
	      <div class="modal-body">
	        <form id="empAddForm" class="form-horizontal">
	          <input id="empId" name="empId" type="hidden">
			  <div class="form-group">
			    <label for="empName" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName" placeholder="姓名">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email" placeholder="邮箱">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="gender" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="genderM" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderF" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="deptName" class="col-sm-2 control-label">部门</label>
			    <div id="dept_add_select" class="col-sm-4">
			    	<!--部门提交部门ID-->
			    	<select class="form-control" name="dId">
			    		<option value="">--请选择--</option>
			    	</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button id="emp_save_btn" type="button" class="btn btn-primary">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript">
		var totalPage;//总页码
		var currentPage;//当前页面
		//1.页面加载完成以后,直接去发送一个ajax请求,要到分页数据
		$(function(){
			to_page(1);
			validator();
		});
		//跳转到指定页面
		function to_page(pn){
			$.ajax({
				url:"${path}/emp/getWithJson",
				data:{"pageNo": pn, "pageSize": '5'},
				type:"get",
				success:function(result){
					//console.log(result);
					//1.在页面上解析并显示员工数据
					build_emp_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//2.解析并显示分页条
					build_emp_nav(result);
				}
			});
		}
		//解析显示表格数据
		function build_emp_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm")
																			.append("<span></span>").addClass("glyphicon glyphicon-wrench emp_update")
																			.append("编辑");
				editBtn.attr("edit_id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
																		    .append("<span></span>").addClass("glyphicon glyphicon-trash emp_delete")
																			.append("删除");
				delBtn.attr("delete_id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);
				$("<tr></tr>").append(empIdTd)
									  .append(empNameTd)
									  .append(genderTd)
									  .append(emailTd)
									  .append(deptNameTd)
									  .append(btnTd)
									  .appendTo("#emps_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第 "+result.extend.pageInfo.pageNum+" 页,共 "+result.extend.pageInfo.pages+" 页,共 "+result.extend.pageInfo.total+" 条记录");
			totalPage = result.extend.pageInfo.pages;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条
		function build_emp_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));//首页
			var preSpan = $("<span></span>").append("&laquo;").attr("aria-hidden","true");
			var prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").append(preSpan));//前一页
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
			var nextSpan = $("<span></span>").append("&raquo;").attr("aria-hidden","true");
			var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append(nextSpan));//后一页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));//末页
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			});
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			//添加首页和上一页
			ul.append(firstPageLi).append(prePageLi)
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));//末页
				if(result.extend.pageInfo.pageNum==item) {
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul).attr("aria-label","Page navigation");
			navEle.appendTo("#page_nav_area");
		}
		
		//添加-新增员工
		$("#forAdd").click(function(){
			$('#empAddForm')[0].reset(); //重置表单
			getDepts("#empAddModal select");
			$('#empAddModal').on('hidden.bs.modal', function() {
		        $("#empAddForm").data('bootstrapValidator').destroy();
		        $('#empAddForm').data('bootstrapValidator', null);
		        validator();
		    });//Modal验证销毁重构
			$("#empAddModal").modal({
				backdrop:"static"
			});
			$("#myModalLabel").html("添加员工");
		});
		
		//查出所有部门信息
		function getDepts(ele){
			$(ele).empty();//先清空
			$.ajax({
				url:"${path}/dept/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(index,item){
						var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
			var pleaseSelect = $("<option></option>").append("--请选择--").attr("value","");
			pleaseSelect.appendTo(ele);
		}
		
		//保存员工信息
		$("#emp_save_btn").click(function(){
			var bootstrapValidator = $("#empAddForm").data("bootstrapValidator");
	        //手动触发验证
	        bootstrapValidator.validate();
	        if(bootstrapValidator.isValid()){
	        	var empId = $("#empId").val();
	        	if(empId==null || empId =="") {//保存
	        		$.ajax({
						url:"${path}/emp/",
						type:"POST",
						data:$("#empAddForm").serialize(),
						success:function(result){
							if(result.code==100) {//成功
								$('#empAddModal').modal('hide');//关闭窗口
								to_page(totalPage);//最后一页
							}else{//失败
								validator();
							}
						},
						error:function(XMLHttpRequest, textStatus, errorThrown) {
							
						}
					}); 
	        	}else{
	        		$.ajax({//修改
						url:"${path}/emp/",
						type:"PUT",
						data:$("#empAddForm").serialize(),
						success:function(result){
							if(result.code==100) {//成功
								$('#empAddModal').modal('hide');//关闭窗口
								to_page(currentPage);//前往当前页
							}else{//失败
								validator();
							}
						},
						error:function(XMLHttpRequest, textStatus, errorThrown) {
							
						}
					}); 
	        	}
	        }
		});
		//校验
		function validator() {
			$("#empAddForm").bootstrapValidator({
			    /**
			    *  指定不验证的情况
			    *  值可设置为以下三种类型：
			    *  1、String  ':disabled, :hidden, :not(:visible)'
			    *  2、Array  默认值  [':disabled', ':hidden', ':not(:visible)']
			    *  3、带回调函数  
			        [':disabled', ':hidden', function($field, validator) {
			            // $field 当前验证字段dom节点
			            // validator 验证实例对象 
			            // 可以再次自定义不要验证的规则
			            // 必须要return，return true or false; 
			            return !$field.is(':visible');
			        }]
			    */
			    excluded: [':disabled', ':hidden', ':not(:visible)'],
			    /**
			    * 指定验证后验证字段的提示字体图标。（默认是bootstrap风格）
			    * Bootstrap 版本 >= 3.1.0
			    * 也可以使用任何自定义风格，只要引入好相关的字体文件即可
			    * 默认样式 
			        .form-horizontal .has-feedback .form-control-feedback {
			            top: 0;
			            right: 15px;
			        }
			    * 自定义该样式覆盖默认样式
			        .form-horizontal .has-feedback .form-control-feedback {
			            top: 0;
			            right: -15px;
			        }
			        .form-horizontal .has-feedback .input-group .form-control-feedback {
			            top: 0;
			            right: -30px;
			        }
			    */
			    feedbackIcons: {
			        valid: 'glyphicon glyphicon-ok',
			        invalid: 'glyphicon glyphicon-remove',
			        validating: 'glyphicon glyphicon-refresh'
			    },
			    /**
			    * 生效规则（三选一）
			    * enabled 字段值有变化就触发验证
			    * disabled,submitted 当点击提交时验证并展示错误信息
			    */
			    live: 'enabled',
			    /**
			    * 为每个字段指定通用错误提示语
			    */
			    message: 'This value is not valid',
			    /**
			    * 指定提交的按钮，例如：'.submitBtn' '#submitBtn'
			    * 当表单验证不通过时，该按钮为disabled
			    */
			    submitButtons: 'button[type="submit"]',
			    /**
			    * submitHandler: function(validator, form, submitButton) {
			    *   //validator: 表单验证实例对象
			    *   //form  jq对象  指定表单对象
			    *   //submitButton  jq对象  指定提交按钮的对象
			    * }
			    * 在ajax提交表单时很实用
			    *   submitHandler: function(validator, form, submitButton) {
			            // 实用ajax提交表单
			            $.post(form.attr('action'), form.serialize(), function(result) {
			                // .自定义回调逻辑
			            }, 'json');
			         }
			    * 
			    */
			    submitHandler: null,
			    /**
			    * 为每个字段设置统一触发验证方式（也可在fields中为每个字段单独定义），默认是live配置的方式，数据改变就改变
			    * 也可以指定一个或多个（多个空格隔开） 'focus blur keyup'
			    */
			    trigger: null,
			    /**
			    * Number类型  为每个字段设置统一的开始验证情况，当输入字符大于等于设置的数值后才实时触发验证
			    */
			    threshold: null,
			    /**
			    * 表单域配置
			    */
			    fields: {
			        //多个重复
			        empName: {
			            //隐藏或显示 该字段的验证
			            enabled: true,
			            //错误提示信息
			            message: '姓名格式不正确',
			            /**
			            * 定义错误提示位置  值为CSS选择器设置方式
			            * 例如：'#firstNameMeg' '.lastNameMeg' '[data-stripe="exp-month"]'
			            */
			            container: null,
			            /**
			            * 定义验证的节点，CSS选择器设置方式，可不必须是name值。
			            * 若是id，class, name属性，<fieldName>为该属性值
			            * 若是其他属性值且有中划线链接，<fieldName>转换为驼峰格式  selector: '[data-stripe="exp-month"]' =>  expMonth
			            */
			            selector: null,
			            /**
			            * 定义触发验证方式（也可在fields中为每个字段单独定义），默认是live配置的方式，数据改变就改变
			            * 也可以指定一个或多个（多个空格隔开） 'focus blur keyup'
			            */
			            trigger: null,
			            // 定义每个验证规则
			            validators: {
	                        notEmpty: {
	                            message: '员工姓名不能为空'
	                        },
	                        stringLength: {
	                            min: 2,
	                            max: 15,
	                            message: '员工姓名长度必须在2到15位之间'
	                        },
	                        threshold :  2 , //有6字符以上才发送ajax请求，（input中输入一个字符，插件会向服务器发送一次，设置限制，6字符以上才开始）
	                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
	                            url: '${path}/emp/checkUser',//验证地址
	                            message: '员工姓名已存在',//提示消息
	                            delay :  1000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置1秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
	                            type: 'POST',//请求方式
	                            // 自定义提交数据，默认值提交当前input value
                                data: function(validator) {
                                      return {
                                        empId: $('#empId').val(),
                                    };
                                 }
	                        },
	                        regexp: {
	                            regexp: /(^[a-zA-Z0-9_-]{4,15}$)|(^[\u2E80-\u9FFF]{2,6})/,
	                            message: '员工姓名只能是2-6位中文或4-15位英文和数字组合'
	                        }
	                    }
			        },
			         email: {
			        	enabled: true,
			        	message: '邮箱格式不正确',
			        	validators: {
			        		notEmpty: {
	                            message: '邮箱不能为空'
	                        },
	                        remote: {
	                            url: '${path}/emp/checkEmail',
	                            message: '邮箱已存在',
	                            delay :  1000,
	                            type: 'POST',//请求方式
	                        	// 自定义提交数据，默认值提交当前input value
                                data: function(validator) {
                                      return {
                                        empId: $('#empId').val(),
                                    };
                                 }
	                        },
	                        emailAddress: {
	                            message: '邮箱格式不正确'
	                        }
			        	}
			        }, 
			        gender: {
			        	container: null,
		                validators: {
		                    notEmpty: {
		                        message: '性别不能为空'
		                    }
		                }
		            },
		            dId: {
		            	validators: {
		                    notEmpty: {
		                        message: '部门不能为空'
		                    }
		                }
		            }
			    }
			});
		}
		//编辑
		$(document).on('click','.emp_update',function(){
			$('#empAddForm')[0].reset(); //重置表单
			getDepts("#empAddModal select");
			$('#empAddModal').on('hidden.bs.modal', function() {
		        $("#empAddForm").data('bootstrapValidator').destroy();
		        $('#empAddForm').data('bootstrapValidator', null);
		        validator();
		    });//Modal验证销毁重构
		    getEmp($(this).attr("edit_id"));//获取员工信息，回显用
			$("#empAddModal").modal({
				backdrop:"static"
			});
			$("#myModalLabel").html("修改员工");
		});
		
		//根据ID,获取员工信息
		function getEmp(id) {
			$.ajax({
				url:"${path}/emp/"+id,
				type:"GET",
				success:function(result){
					var employee = result.extend.employee;
					$("#empId").val(employee.empId);
					$("#empName").val(employee.empName);
					$("#email").val(employee.email);
					$("input[name=gender]").val([employee.gender]);//单选框
					$("#empAddModal select").val([employee.dId]);//下拉框
				}
			});
		}
	</script>
</body>
</html>