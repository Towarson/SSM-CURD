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
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女"}</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
								 	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!--显示分页信息 -->
		<div class="row">
			<!-- 分页的文字信息 -->
			<div class="col-md-6">
				当前第 ${pageInfo.pageNum } 页,共 ${pageInfo.pages } 页,共 ${pageInfo.total } 条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${path }/emps?pageNo=1">首页</a></li>
				  	<c:if test="${pageInfo.hasPreviousPage}">
				  		 <li>
					      <a href="${path }/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				  	</c:if>
				    <c:forEach items="${pageInfo.navigatepageNums }" var="nums">
				    	<c:if test="${nums==pageInfo.pageNum}">
				    		<li class="active"><a href="#">${nums}</a></li>
				    	</c:if>
				    	<c:if test="${nums != pageInfo.pageNum}">
				    		<li><a href="${path }/emps?pageNo=${nums}">${nums}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}"> 
				    	<li>
					      <a href="${path }/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <li><a href="${path }/emps?pageNo=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>