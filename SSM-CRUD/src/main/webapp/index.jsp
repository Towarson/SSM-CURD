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
	<!--后台返回json数据，前台拼串完成列表循环  -->
	<!-- 搭建显示页面-->
	<div class="container">
		<!-- 标题-->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--按钮-->
		<div id="toolbar">
             <button id="forAdd" class="btn btn-primary" data-toggle="modal" data-target="#addModal">新增</button>
             <button id="forDel" class="btn btn-danger"  data-toggle="modal" data-target="#addModal">删除</button>
        </div>
        
		<!-- 显示表格数据 -->
		<table id="emp-table" class="table table-hover" data-toolbar="#toolbar"></table>
		
		<!--时钟 -->
		<div class="your-clock"></div>
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
			//根据窗口调整表格高度
            $(window).resize(function() {
                $('#emp-table').bootstrapTable('resetView', {
                    height: tableHeight()
                });
            });
			initTable();
			validator();
			
		});
		//创建Table
		function initTable(){
			$("#emp-table").bootstrapTable({
				url:"${path}/emp/list",
				method:'POST',
		        dataType:'json',
		        contentType: "application/x-www-form-urlencoded",//必须的,操你大爷！！！
		        height: tableHeight(),				//高度调整
		        search: true,						//是否搜索
		        searchAlign: "left",				//查询框对齐方式
		        cache: false,
		        striped: true,                      //是否显示行间隔色
		        sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
		        height: $(window).height() - 110,
		        width:$(window).width(),
		        showColumns:true,
		        queryParamsType:'',//默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort.设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
		        queryParams: function getParams(params) {
                    params.other = "otherInfo";//params obj
                    return params;
                },									//前端调用服务时，会默认传递上边提到的参数，如果需要添加自定义参数，可以自定义一个函数返回请求参数
		        searchOnEnterKey: false,			//回车搜索
		        showRefresh: true,					//刷新按钮
		        showColumns: true,					//列选择按钮
		        showToggle: true,					//是否显示 切换试图（table/card）按钮
		        showPaginationSwitch: true,			//是否显示 数据条数选择框
		        clickToSelect: true,				//设置true 将在点击行时，自动选择rediobox 和 checkbox
		        buttonsAlign: "left",				//按钮对齐方式
		        toolbar: "#toolbar",				//指定工具栏
		        buttonsAlign: "left",				//按钮对齐方式
		        toolbarAlign: "right",				//工具栏对齐方式
		        minimumCountColumns:2, 				//最少允许的列数
		        pagination:true,
		        pageNumber:1,                       //初始化加载第一页，默认第一页
		        pageSize: 10,                       //每页的记录行数（*）
		        pageList: [10, 20, 50, 100],        //可供选择的每页的行数（*）
		        columns: [ 
		          {
                        title: "全选",
                        field: "select",
                        checkbox: true
                  },{
                      field: '',
                      title: '编号',
                      formatter: function (value, row, index) {
                      		return index+1;
          			  }
                  },{
                      field : 'empName',
                      title : '员工姓名',
                      align : 'center',
                      valign : 'middle',
                      sortable : true
                  }, {
                      field : 'gender',
                      title : '性别',
                      align : 'center',
                      valign : 'middle',
                      sortable : true,
                      formatter : function (value, row, index){
                    	  var gender = (value=="M" ? "男" : "女");
                          return gender;
                      }
                  }, {
                      field : 'email',
                      title : '邮箱',
                      align : 'center',
                      valign : 'middle'
                  }, {
                      field : 'department.deptName',
                      title : '部门',
                      align : 'center',
                      valign : 'middle',
                      sortable : true
                  }, {
                      field : '',
                      title : '操作',
                      align : 'center',
                      valign : 'middle',
                      formatter : function (value, row, index){
                    	  return "<a href='javascript:void(0)' onclick='javascript:updateEmp(\""+index+"\")'>修改</a>&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' onclick='javascript:deleteEmp(\""+index+"\")'>删除</a>";
                      }
                  }],
			});
		}
		//高度
        function tableHeight() {
            return $(window).height() - 120;
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
		
		//修改
		function updateEmp(index){
			$('#empAddForm')[0].reset(); //重置表单
			var $table = $('#emp-table');
			alert(JSON.stringify($table.bootstrapTable('getData')));
			alert('getRowByUniqueId: ' + JSON.stringify($table.bootstrapTable('getRowByUniqueId', 1)));
			return false;
			var row = $('#emp-table').bootstrapTable('getRowByUniqueId', index);//根据行数获取该行的数据
			getDepts("#empAddModal select");
			$('#empAddModal').on('hidden.bs.modal', function() {
		        $("#empAddForm").data('bootstrapValidator').destroy();
		        $('#empAddForm').data('bootstrapValidator', null);
		        validator();
		    });//Modal验证销毁重构
		    getEmp(row.empId);//获取员工信息，回显用
			$("#empAddModal").modal({
				backdrop:"static"
			});
			$("#myModalLabel").html("修改员工");
		}
		
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
								$('#emp-table').bootstrapTable('refresh');  
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
								$('#emp-table').bootstrapTable('refresh');  
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
		
		//删除
		function deleteEmp(index){
			var row = $('#emp-table').bootstrapTable('getRowByUniqueId', index);//根据行数获取该行的数据
			if(confirm("确认删除【"+row.empName+"】吗？")){
				//2.确认删除
				$.ajax({
					url:"${path}/emp/"+row.empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						$('#emp-table').bootstrapTable('refresh');  
					}
				});
			}
		}
		
		//批量删除
		$("#forDel").click(function(){
			var rows = $('#emp-table').bootstrapTable('getSelections');//获取所有被选中的行
			if(rows.length>=1){
				if(confirm("你确认要删除吗？")){
					var empIds = '';
	 				for(var i=0;i<rows.length;i++){
	 					empIds = empIds+rows[i].empId;
	    			    if(i<rows.length-1){
	    			    	empIds=empIds+",";
	    			    }
	 				}
					$.ajax({
						url:"${path}/emp/"+empIds,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							$('#emp-table').bootstrapTable('refresh');  
						}
					});
				}
			}else{
				$.messager.alert('提示消息','请先选择一条记录!','info');
			}
		});
		
		
		//校验
		function validator() {
			$("#empAddForm").bootstrapValidator({
			    excluded: [':disabled', ':hidden', ':not(:visible)'],
			    feedbackIcons: {
			        valid: 'glyphicon glyphicon-ok',
			        invalid: 'glyphicon glyphicon-remove',
			        validating: 'glyphicon glyphicon-refresh'
			    },
			    live: 'enabled',
			    message: 'This value is not valid',
			    submitButtons: 'button[type="submit"]',
			    submitHandler: null,
			    trigger: null,
			    threshold: null,
			    fields: {
			        empName: {
			            enabled: true,//隐藏或显示 该字段的验证
			            message: '姓名格式不正确',//错误提示信息
			            container: null,
			            selector: null,
			            trigger: null,
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
	</script>
	<script type="text/javascript">
		var clock = new FlipClock($('.your-clock'), {//对应的是(天,时,分,12小时制,24小时制,计数)
			clockFace: 'TwentyFourHourClock',//计数模式
		});
		//设置时间格式的时钟
		var date = new Date();
	        clock = $('.clock').FlipClock(date, {
	        clockFace: 'TwentyFourHourClock'
		});
	</script>
</body>
</html>