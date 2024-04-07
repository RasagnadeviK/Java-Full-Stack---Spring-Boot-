<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>
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
	<div class="admin">
		<div class="card text-center mt-3 mx-auto" style="width: 36rem;">
			<div class="card-header custom-bg text-light">
				<h3>Please Review Before Paying</h3>
			</div>
			<div class="card-body text-center">
				<form action="execute_payment" method="post">
					<input type="hidden" name="paymentId" value="${param.paymentId}" />
					<input type="hidden" name="PayerID" value="${param.PayerID}" />
					<div class="table-responsive">
						<div class="text-center">
							<h3>Transaction Details:</h3>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Description:</th>
									<td>${transaction.description}</td>
								</tr>

								<tr>
									<th scope="col">Subtotal:</th>
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

					<div class="table-responsive">
						<div class="text-center mt-1">
							<h3>Payer Information:</h3>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>First Name:</th>
									<td>${payer.firstName}</td>
								</tr>
								<tr>
									<th>Last Name:</th>
									<td>${payer.lastName}</td>
								</tr>
								<tr>
									<th>Email:</th>
									<td>${payer.email}</td>
								</tr>
							</thead>
						</table>
					</div>

					<div class="table-responsive">
						<div class="text-center mt-1">
							<h3>Shipping Address:</h3>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>Recipient Name:</th>
									<td>${shippingAddress.recipientName}</td>
								</tr>
								<tr>
									<th>Address:</th>
									<td>${shippingAddress.line1}</td>
								</tr>
								<tr>
									<th>City:</th>
									<td>${shippingAddress.city}</td>
								</tr>
								<tr>
									<th>State:</th>
									<td>${shippingAddress.state}</td>
								</tr>
								<tr>
									<th>Country Code:</th>
									<td>${shippingAddress.countryCode}</td>
								</tr>
								<tr>
									<th>Postal Code:</th>
									<td>${shippingAddress.postalCode}</td>
								</tr>
							</thead>
						</table>
					</div>

					<div class="text-center">
						<input type="submit" class="btn custom-bg text-white"
							value="Pay Now" />
					</div>

				</form>
			</div>

		</div>
	</div>
<!-- Footer Start -->
	<div class="container-fluid bg-light mt-5 py-5 custom-bg">
        <div class="container pt-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Get In Touch</h5>
                    <p class="mb-4">No dolore ipsum accusam no lorem. Invidunt sed clita kasd clita et et dolor sed dolor</p>
                    <p class="mb-2"><i class="bi bi-geo-alt text-primary me-2"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="bi bi-envelope-open text-primary me-2"></i>info@example.com</p>
                    <p class="mb-0"><i class="bi bi-telephone text-primary me-2"></i>+012 345 67890</p>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Quick Links</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                        <a class="text-body" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Popular Links</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                        <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                        <a class="text-body" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Newsletter</h5>
                    <form action="">
                        <div class="input-group">
                            <input type="text" class="form-control p-3" placeholder="Your Email">
                            <button class="btn btn-primary">Sign Up</button>
                        </div>
                    </form>
                    <h6 class="text-uppercase mt-4 mb-3">Follow Us</h6>
                    <div class="d-flex">
                        <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-twitter"></i></a>
                        <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-facebook"></i></a>
                        <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-linkedin"></i></a>
                        <a class="btn btn-outline-primary btn-square" href="#"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
                <div class="col-12 text-center text-body">
                    <a class="text-body" href="">Terms & Conditions</a>
                    <span class="mx-1">|</span>
                    <a class="text-body" href="">Privacy Policy</a>
                    <span class="mx-1">|</span>
                    <a class="text-body" href="">Customer Support</a>
                    <span class="mx-1">|</span>
                    <a class="text-body" href="">Payments</a>
                    <span class="mx-1">|</span>
                    <a class="text-body" href="">Help</a>
                    <span class="mx-1">|</span>
                    <a class="text-body" href="">FAQs</a>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid bg-dark text-white-50 py-4">
        <div class="container">
            <div class="row g-5">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-md-0">&copy; <a class="text-white" href="#">Your Site Name</a>. All Rights Reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0">Designed by <a class="text-white" href="https://htmlcodex.com">HTML Codex</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>