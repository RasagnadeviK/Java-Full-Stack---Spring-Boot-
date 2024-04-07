<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Receipt</title>
<%@ include file="components/common_cs_js.jsp"%>
<style type="text/css">
table {
	border: 0;
}

table td {
	padding: 5px;
}
</style>
</head>
<body>
	<%@ include file="components/navbar.jsp"%>
	<div class="text-center">
		<h1>Payment Done. Thank you for purchasing our products</h1>
	</div>
	<div class="admin">
		<div class="card text-center mt-3 mx-auto" style="width: 36rem;">
			<div class="card-header custom-bg text-light">
				<h3>Receipt Details:</h3>
			</div>
			<div class="card-body text-center">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th>Merchant:</th>
								<td>SHOPFASHION PVT LTD.</td>
							</tr>
							<tr>
								<th>Payer:</th>
								<td>${payer.firstName}${payer.lastName}</td>
							</tr>

							<tr>
								<th>Subtotal:</th>
								<td>${transaction.amount.details.subtotal}USD</td>
							</tr>
							<tr>
								<th>Shipping:</th>
								<td>${transaction.amount.details.shipping}USD</td>
							</tr>
							<tr>
								<th>Tax:</th>
								<td>${transaction.amount.details.tax}USD</td>
							</tr>
							<tr>
								<th>Total:</th>
								<td>${transaction.amount.total}USD</td>
							</tr>
						</thead>
					</table>
				</div>

				<div class="text-center">
					<a href="index.jsp"><button class="btn custom-bg text-white">Shop
							More</button></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>