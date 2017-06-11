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
			<div class=".col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--按钮-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>员工姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
	
				</table>
			</div>
		</div>
		<!--显示分页信息 -->
		<div class="row">
			<!-- 分页的文字信息 -->
			<div class="col-md-6">
				当前第  页,共  页,共  条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">

			</div>
		</div>
	</div>
	<script type="text/javascript">
		//1.页面加载完成以后,直接去发送一个ajax请求,要到分页数据
	
	</script>
</body>
</html>