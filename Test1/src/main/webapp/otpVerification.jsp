<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>OTP Verification</title>
    <%@ include file="components/common_cs_js.jsp" %>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3 admin">
                <div class="card mt-3">
                    <%@ include file="components/message.jsp" %>
                    <div class="card-header custom-bg text-white">
                        <h3>Verify OTP</h3>
                    </div>
                    <div class="card-body">
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="otp">Enter OTP</label>
                                <input type="text" class="form-control" id="otp" name="otp" placeholder="Enter OTP" required>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn text-white custom-bg">Verify OTP</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
