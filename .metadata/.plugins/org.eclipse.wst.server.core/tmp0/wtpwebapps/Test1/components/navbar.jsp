<%@ page import ="com.ecommerce.pojo.*"%>
<%@ page import ="com.ecommerce.dao.*"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.*"%>
<%
     User user=(User)session.getAttribute("active-user"); 
%>

<%
         CategoryDaoImp cdao=new CategoryDaoImp();
         List<Category> cl=cdao.getAllCategory();
%>
<div class="container-fluid bg-dark py-3 px-lg-5 d-none d-lg-block">
        <div class="row">
            <div class="col-md-6 text-center text-lg-left mb-2 mb-lg-0">
                <div class="d-inline-flex align-items-center">
                    <a class="text-body pr-3" href=""><i class="fa fa-phone-alt mr-2"></i>+91 9030992019</a>
                    <span class="text-body">|</span>
                    <a class="text-body px-3" href=""><i class="fa fa-envelope mr-2"></i>2100090151csit@gmail.com</a>
                </div>
            </div>
            <div class="col-md-6 text-center text-lg-right">
                <div class="d-inline-flex align-items-center">
                    <a class="text-body px-3" href="https://facebook.com/freewebsitecode/">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a class="text-body px-3" href="https://freewebsitecode.com/">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a class="text-body px-3" href="https://freewebsitecode.com/">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a class="text-body px-3" href="https://freewebsitecode.com/">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a class="text-body pl-3" href="https://youtube.com/freewebsitecode/">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
 
<nav class="navbar navbar-expand-lg navbar-dark custom-bg">

<div class="container-fluid">
  <a class="navbar-brand" href="index.jsp"><h3><i>Precious Paw</i></h3></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
    
    
    <%
         if(user!=null)
         {
        	 
        	 String userType=user.getUserType();
        	 if(userType.equals("admin"))
        	 {
    %>
                 <li class="nav-item active">
                    <a class="nav-link" href="admin.jsp"><b>Admin Page</b> <span class="sr-only">(current)</span></a>
                 </li>
    <%
        	 }
         }
    %>
      <li class="nav-item active dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <b> Categories</b>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="index.jsp?category=0" >All</a>
               <%
                    for(Category c: cl)
                    {    	
               %> 
                         <a class="dropdown-item" href="index.jsp?category=<%=c.getCategoryId() %>"><%=c.getCategoryTitle() %></a>     
               <%
                    }
               %>
          
        </div>
      </li>
      <li class="nav-item active ml-2" data-toggle="modal" data-target=".contactusmodal">
          <a href="index2.jsp" class="nav-item nav-link">Home</a>
      </li>
      <li class="nav-item active ml-2" data-toggle="modal" data-target=".aboutusmodal">
          <div class="nav-link" ><b>About us</b></div>
      </li>
      
      <li class="nav-item active ml-2">
    <a class="nav-link" href="contact.jsp"><b>Contact us</b></a>
</li>
      <li class="nav-item active ml-2">
          <a class="nav-link" href="services.jsp"><b>Services</b></a>
      </li>
      <li class="nav-item active ml-2">
          <a class="nav-link" href="organization.jsp"><b>Organizations</b></a>
      </li>
     
    </ul>
    
    <form class="form-inline my-2 my-lg-0" action="ProductOperationServlet" method="post">
      <input type="hidden" name="action" value="searchProduct">
      <input class="form-control mr-sm-2" type="text" placeholder="Search product" aria-label="Search" size="40" name="search">
      <button type="submit" class="btn btn-light" style="color:#ff9800"><b>Search</b></button>
    </form>
    
    <%
        if(user!=null)
        {
        	  
    %>
    
          <ul class="navbar-nav ml-auto">
              
              <%
                  if(user.getUserType().equals("normal"))
                  {
              %>
                     <li class="nav-item active">
    <a class="nav-link" href="mycart.jsp">
        <img src="images/cart.png" style="width:23px;" alt="img">
        (<%= new CartDaoImp().totalCartByUserId(user.getUserId()) %>)
    </a>
</li>
                     
                     <li class="nav-item active" data-toggle="modal" data-target="#showmyordermodal">
                        <a class="nav-link" href="#"><b>My Orders</b></a>
                     </li>
              <%
                  }
              %>
          
             <li class="nav-item active">
    <a class="nav-link" href="myprofile.jsp"><b><%= user.getUserName()%></b></a>
</li>
             
             <li class="nav-item active">
             <div class="nav-link" data-toggle="modal" data-target=".changepasswordmodal"><b>change password</b></div>
             </li>  
      
             <li class="nav-item active" data-toggle="modal" data-target=".logout-modal">
             <a class="nav-link" href="#" ><b>Logout</b></a>
             </li>    
         </ul>
   
    <%
        }
    
        else
        {
    %>
    <ul class="navbar-nav ml-auto">
       <li class="nav-item active">
        <div class="nav-link" data-toggle="modal" data-target=".forgetpasswordmodal"><b>Forget password</b></div>
      </li> 
    
      <li class="nav-item active">
        <a class="nav-link" href="register.jsp"><b>Register</b></a>
      </li>  
      
      <li class="nav-item active">
        <a class="nav-link" href="login.jsp"><b>Login</b></a>
      </li>    
    </ul>
    
    <%
        }
    %>     
    
  </div>
  </div>
</nav>

<!-- show profile modal -->

<div class="modal fade" id="showprofilemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >MY PROFILE</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form >
         
         <div class="container text-center">
                   <img style="max-width:200px" class="img-fluid rounded-circle" src="userProfilePic/<%if(user!=null){ %><%=user.getUserPic() %><%} %>" alt="users_pic" >
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
 
  <div class="container text-center">
       <button type="button" class="btn custom-bg text-light" data-dismiss="modal">Close</button>
  </div>   
</form>
      </div>
    </div>
  </div>
</div>

<!--  -->

<!-- show my cart modal -->



<!--  -->

<!-- show my order modal -->

<div class="modal fade" id="showmyordermodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >MY ORDERS</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     <%
      if(user!=null)
      {
    	  List<Order> l=new OrderDaoImp().getOrderByUserId(user.getUserId());
    	 
     %>
      <div class="modal-body">
        
        <%
            if(l.isEmpty())
            {
        %>
        <div class="text-center">
        <h1>NO ORDERS MADE BY YOU !!</h1>
        <hr>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        <%
            }
        
            else
            {
            	
            	
        %>
        <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Product Image</th>
      <th scope="col">Product Title</th> 
      <th scope="col">Product Description</th>    
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col">Ordered Date</th>
      <th scope="col">Delivery Date</th>
    </tr>
  </thead>
  
 
  
  <tbody>
   <%
      OrderDaoImp odao=new OrderDaoImp();
      
   %>
  
   <%
      for(Order o:l)
      {
    	  int productId=o.getProdctId();
    	  Product p=new ProductDaoImp().getProductById(productId);
   %>
    <tr class="text-center">
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="productImages/<%=p.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getProductTitle() %></td>
      <td class="mid-align"><%=p.getProductDescription() %></td>
      <td class="mid-align"><%=o.getQuantity() %></td>
      <td class="mid-align"><%=o.getPrice() %></td>
      <td class="mid-align"><%=o.getOrderesDate() %></td>
      <td class="mid-align"><%if(o.getDeliveryDate().equals("0")){ %><span style="color:red;"> <%="processing.."%></span>    <%} else { %> <%=o.getDeliveryDate() %><%} %></td>
    </tr>
    <%
      }
    %>
  </tbody>
 
  
</table>
<hr>

<div class="text-right">
    <p style="font-size:25px;"><b>Total Price :&#8377;<%=new OrderDaoImp().totalOrderPrice(user.getUserId()) %>/- </b></p> 
</div>
<hr>

      <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Close</button>

       <%
            }
       %>
         
      </div>
  <%
           
      }
  %>
    </div>
  </div>
</div>
</div>

<!--  -->

<!-- Logout modal -->

<div class="modal fade logout-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Log Out</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body text-center">
            <h5>Do you want to logout?</h5>
          
          <div class="text-center">
            <a href="LoginServlet"><button type="button" class="btn custom-bg text-white">Yes</button></a>
            <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">No</button>
          </div> 
     </div>     
    </div>
  </div>
</div>

<!-- *********** -->

<!-- About us modal -->

<div class="modal fade aboutusmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
       <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >About Us</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div> 
      <div class="modal-body">
        <div class="container">
        <p style="font-size:20px;">
          <b>
              Welcome to our pet-centric platform! A pet website is a virtual haven where you can explore a world dedicated to the well-being, trade, and interactions involving our beloved furry companions.

Pets, from our loyal dogs to our enchanting cats, bring immense joy to our lives. This website celebrates the beauty of pet ownership, offering avenues for the exchange of services, information, and connections within the pet-loving community.

Just like the age-old barter system and trade that has been a part of human history, pet enthusiasts and owners have always sought ways to connect and provide for their furry friends. Whether it's pet services, sharing pet-related knowledge, or finding that perfect toy, our platform facilitates this exchange.

Transactions, both locally and globally, have been the backbone of the pet community. Now, in the digital realm, we embrace this legacy, creating a space where pet lovers can come together, trade, and seek services.

However, as we step into the digital sphere, we're acutely aware of the importance of data privacy. Stringent data protection laws govern our operations. Prior to engaging in our pet-oriented venture, it's crucial to understand and comply with all the legal policies necessary to safeguard the data and privacy of our users.

Our pet-centric platform aims to merge the joy of pet ownership with a secure, user-friendly online experience, fostering a community that values the love and care for our adorable companions.
          </b>
        </p>
        </div>
      </div>
      <div class="modal-footer">
       <div class="text-center">
        <button type="button" class="btn custom-bg text-white" data-dismiss="modal">Close</button>
       </div>
      </div>
    </div>
  </div>
</div>
<!-- ********** -->

<!-- Contact us modal -->



<!-- change password modal -->

<div class="modal fade changepasswordmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Change Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="LoginServlet" method="post">
          <input type="hidden" name="action" value="changePassword">
         
  <div class="form">
 
    <div class="form-group ">
      <label for="inputPassword4">Email</label>
      <input type="email" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserEmail() %><%} %>" readonly>
    </div>
    <div class="form-group">
      <label for="inputPassword4">Password</label>
      <input type="password" class="form-control" id="pass" name="pass" >
    </div>
    <div class="form-group">
      <label for="inputPassword4">Confirm Password</label>
      <input type="password" class="form-control" id="cpass" name="cpass">
    </div>
  </div>
 
  <div class="container text-center">
       
       <input type="submit" class="btn custom-bg text-light" value="Change">
       <button type="button" class="btn custom-bg text-light ml-5" data-dismiss="modal">Close</button>
                                      
  </div>   
</form>
      </div>
    </div>
  </div>
</div>


<!--  -->

<!-- forget password modal -->

<div class="modal fade forgetpasswordmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Forget Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="LoginServlet" method="post">
          <input type="hidden" name="action" value="forgetPassword">
         
  <div class="form">
 
    <div class="form-group ">
      <label for="inputPassword4">Email</label>
      <input type="email" class="form-control" id="email" name="email">
    </div>
    <div class="form-group ">
      <label for="inputPassword4">Phone</label>
      <input type="text" class="form-control" id="phone" name="phone">
    </div>
    <div class="form-group">
      <label for="inputPassword4">Password</label>
      <input type="password" class="form-control" id="pass" name="pass" >
    </div>
    <div class="form-group">
      <label for="inputPassword4">Confirm Password</label>
      <input type="password" class="form-control" id="cpass" name="cpass">
    </div>
  </div>
 
  <div class="container text-center">
       
       <input type="submit" class="btn custom-bg text-light" value="Change">
       <button type="button" class="btn custom-bg text-light ml-5" data-dismiss="modal">Close</button>
                                      
  </div>   
</form>
      </div>
    </div>
  </div>
</div>


<!--  -->

