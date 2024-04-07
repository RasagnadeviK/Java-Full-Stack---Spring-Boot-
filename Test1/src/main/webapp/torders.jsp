<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    <%@ page import ="com.ecommerce.pojo.*"%>
    <%@ page import ="com.ecommerce.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>

    <%
         User user2=(User)session.getAttribute("active-user");
         if(user2==null)
         {
        	 session.setAttribute("message","You are not logged in! Login first...");
		     response.sendRedirect("login.jsp");
		     return;
         }
         
         else
         {
             if(user2.getUserType().equals("normal"))
             {
            	 session.setAttribute("message","You are not Admin! Do not Access this...");
                 session.removeAttribute("active-user");
                 response.sendRedirect("login.jsp");
    		     return;
             }     
         }
    %>
    
    <%
        List<Category> li=new CategoryDaoImp().getAllCategory(); 
    %>
    
<!DOCTYPE html>
<html>
<style>
.custom-bg {
        background-color: #f0f0f0; /* Your desired background color */
    }
</style>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page-Precious Paw</title>
<%@ include file="components/common_cs_js.jsp"%>

</head>
<body>
 <%@ include file="components/navbar.jsp"%>
 
 <div class="container admin mt-2">
     <%@ include file="components/message.jsp"%>
        <div class="modal-dialog modal-lg modal-size" role="document">
            <div class="modal-content">
                <div class="modal-header custom-bg text-white text-center">
                    <h5 class="modal-title">TOTAL ORDERS</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

        
        <%
            List<Order> lor=new OrderDaoImp().getAllOrder();
            if(lor.isEmpty())
            {
        %>
        <div class="text-center">
        <h1>NO ORDERS MADE BY ANYONE !!</h1>
        <hr>
        <button type="button" class="btn btn-secondary" onclick="window.location.href='admin.jsp';">Close</button>


        </div>
        <%
            }
        
            else
            {
            	
            	
        %>
        <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr class="text-center">
      <th scope="col">User Id</th>
      <th scope="col">User Name</th>
      <th scope="col">User Email</th>
      <th scope="col">User Phone</th>
      <th scope="col">Product Image</th>
      <th scope="col">Product Title</th>    
      <th scope="col">Qnty</th>
      <th scope="col">Price</th>
      <th scope="col">Ord. date</th>
      <th scope="col">Del. date</th>
      <th scope="col">Set Delivery date</th>
    </tr>
  </thead>
  
 
  
  <tbody>
  
   <%
      for(Order o:lor)
      {
    	  int productId=o.getProdctId();
    	  Product p1=new ProductDaoImp().getProductById(productId);
    	  User us=new UserDaoImp().getUserByUserId(o.getUserId());
   %>
    <tr class="text-center">
      <td class="mid-align"><%=us.getUserId() %></td>
      <td class="mid-align"><%=us.getUserName() %></td>
      <td class="mid-align"><%=us.getUserEmail() %></td>
      <td class="mid-align"><%=us.getUserPhone() %></td>
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="productImages/<%=p1.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p1.getProductTitle() %></td>
      <td class="mid-align"><%=o.getQuantity() %></td>
      <td class="mid-align"><%=o.getPrice() %></td>
      <td class="mid-align"><%=o.getOrderesDate() %></td>
      <td class="mid-align"><%if(o.getDeliveryDate().equals("0")){ %><span style="color:red;"> <%="NA"%></span>    <%} else { %> <%=o.getDeliveryDate() %><%} %></td>
      <td class="mid-align">
      <form action="OrderServlet" method="post">
          <input type="hidden" name="action" value="addDelivery">
          <input type="hidden" name="userId" value=<%=us.getUserId() %>>
          <input type="hidden" name="productId" value="<%=p1.getProductId()%>">
          <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
          <div class="form-group mx-sm-3 mb-2">
            <input type="text" class="form-control" name="deliveryDate" placeholder="Delivery Date" size="85" required>
          </div>
          <button type="submit" class="btn custom-bg text-white mb-2">Set</button>
     </form>
     </td>
    </tr>
    <%
      }
    %>
  </tbody>
 
  
</table>
</div>
<hr>

<div class="text-center">
      <button type="button" class="btn btn-secondary" onclick="window.location.href='admin.jsp';">Close</button>


</div>
       <%
            }
       %>
         
    </div>
  </div>
</div>
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
