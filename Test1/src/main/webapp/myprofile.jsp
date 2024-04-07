<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Profile - Precious Paw</title>
    <!-- Add your CSS and JS includes or links here -->
    <%@ include file="components/common_cs_js.jsp"%>
    <style>
        /* Add any additional styles here */
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp"%>

    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header custom-bg text-white text-center">
                <h5 class="modal-title">MY PROFILE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="container text-center">
                        <img style="max-width:200px" class="img-fluid rounded-circle" src="userProfilePic/<%if(user!=null){ %><%=user.getUserPic() %><%} %>" alt="users_pic">
                    </div>
                    <div class="form-row mt-3">
                        <div class="form-group col-md-4">
                            <label for="inputEmail4">Name</label>
                            <input type="text" class="form-control" id="inputEmail4" value="<%if(user!=null){ %><%=user.getUserName() %><%} %>" readonly>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="inputPassword4">Email</label>
                            <input type="email" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserEmail() %><%} %>" readonly>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="inputPassword4">Phone</label>
                            <input type="text" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserPhone() %><%} %>" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress">Address</label>
                        <textarea class="form-control" id="inputAddress" placeholder="1234 Main St" rows="3" readonly><%if(user!=null){ %><%=user.getUserAddress() %><%} %></textarea>
                    </div>
                    <!-- Add more form fields as needed -->
                    <div class="form-row mt-3">
                        <!-- Add more form fields here -->
                    </div>
                    <div class="container text-center">
                        <button type="button" class="btn custom-bg text-light" data-dismiss="modal">Close</button>
                    </div>   
                </form>
            </div>
        </div>
    </div>
</body>
</html>
