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
<head>
<style>
.custom-bg {
        background-color: #f0f0f0; /* Your desired background color */
    }
</style>
<meta charset="ISO-8859-1">
<title>Admin Page-Precious Paw</title>
<%@ include file="components/common_cs_js.jsp"%>

</head>
<body>
 <%@ include file="components/navbar.jsp"%>
 
 <div class="container admin mt-2">
     <%@ include file="components/message.jsp"%>
      <div class="row mt-3">
           <div class="col-md-4">
                 <div class="card hover" data-toggle="modal" data-target="#show-users-modal">
                     <div class="card-body text-center">
                         <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/user.png" alt="users_pic" >
                         </div>
                         <h1><%=new UserDaoImp().getTotalUser() %></h1>
                         <h2 class="text-uppercase text-muted">Users</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#show-category-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/category.png" alt="users_pic" >
                         </div>
                          <h1><%=new CategoryDaoImp().getTotalCategory() %></h1>
                          <h2 class="text-uppercase text-muted">Total Category</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#show-product-modal">
                     <div class="card-body text-center">
                           <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/product.png" alt="users_pic" >
                           </div>
                           <h1><%=new ProductDaoImp().getTotalProduct() %></h1>
                           <h2 class="text-uppercase text-muted">Total Products</h2>
                     </div>
                 </div>
           </div>
      </div>
      
      <div class="row mt-3">
    <div class="col-md-4">
        <a href="torders.jsp" class="card hover">
            <div class="card-body text-center">
                <div class="container">
                    <img style="max-width:120px" class="img-fluid rounded-circle" src="images/check.png" alt="users_pic">
                </div>
                <h1 class="text-lowercase text-muted"><%=new OrderDaoImp().totalOrdersCount() %></h1>
                <h2 class="text-uppercase text-muted">Total Orders</h2>
            </div>
        </a>
    </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#add-category-modal">
                     <div class="card-body text-center">
                          <div class="container md-5">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addCategory.jpg" alt="users_pic" >
                         </div>
                          <p class="text-lowercase text-muted mt-2 " style="font-size:22px">click to add category</p>
                          <h2 class="text-uppercase text-muted mt-1">Add Category</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#add-product-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addproduct.png" alt="users_pic" >
                         </div>
                          <p class="text-lowercase text-muted mt-2 " style="font-size:22px">click to add product</p>
                          <h2 class="text-uppercase text-muted">Add Product</h2>
                     </div>
                 </div>
           </div>
           
      </div>
      
 </div> 
  
<!-- add category modal -->
     
<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Fill category details.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post">
               <input type="hidden" name="action" value="addCategory">
               <div class="form-group">
                   <input type="text" class="form-control" name="categoryTitle" placeholder="Enter Category Title here" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:250px" class="form-control" name="categoryDescription" placeholder="Enter Category Description here" required></textarea>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Add Category</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>
      
      
  <!-- end add category modal -->
  
  <!-- add product modal -->
     
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Add Product details.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
               <input type="hidden" name="action" value="addProduct">
               <div class="form-group">
                   <input type="text" class="form-control" name="productTitle" placeholder="Enter Product Title here" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:150px" class="form-control" name="productDescription" placeholder="Enter Product Description here" required></textarea>
               </div>
               
               <div class="form-group">
                   <input type="number" class="form-control" name="productPrice" placeholder="Enter Product Price here" required>
               </div>
               
               <div class="form-group">
                   <input type="text" class="form-control" name="productQuantity" placeholder="Enter Product Quantity here" required>
               </div>
               
               <div class="form-group">
                   <input type="text" class="form-control" name="productDiscount" placeholder="Enter Product Discount in (%)" required>
               </div>
               
               <div class="form-group">
                   <select name="productCategoryId" class="form-control">
                       <option value="">Select Category</option>
                       <%
                           for(Category category:li)
                           {
                       %>
                       <option value="<%=category.getCategoryId()%>"><%=category.getCategoryTitle() %></option>
                       <%
                           }
                       %>
                   </select>
               </div>
               
               <div class="form-group">
                   <label>Select Product Pic</label><br>
                   <input type="file" class="form-control" name="productPic" required>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Add Product</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>   
   
  <!-- end add product modal -->
  
  <!-- show users modal -->
     
<div class="modal fade" id="show-users-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Users</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">User Id</th>
      <th scope="col">Photo</th>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Mobile</th>
      <th scope="col">Address</th>
    </tr>
  </thead>
  <tbody>
   <%
      UserDaoImp udao=new UserDaoImp();
      List<User> l=udao.getAllUser("normal");
   %>
  
   <%
      for(User u:l)
      {
   %>
    <tr>
      <th scope="row" class="mid-align"><%=u.getUserId() %></th>
      <td><img style="max-width:70px" class="img-fluid rounded-circle" src="userProfilePic/<%=u.getUserPic() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=u.getUserName() %></td>
      <td class="mid-align"><%=u.getUserEmail() %></td>
      <td class="mid-align"><%=u.getUserPhone() %></td>
      <td class="mid-align"><%=u.getUserAddress() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>
        
<!-- end of show users modal -->

<!-- show category modal -->

<div class="modal fade" id="show-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Category</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Category Id</th>
      <th scope="col">Category Name</th>
      <th scope="col">Category Description</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
   <%
      CategoryDaoImp cd=new CategoryDaoImp();
      List<Category> lc=cd.getAllCategory();
   %>
  
   <%
      for(Category c:lc)
      {
   %>
    <tr>
      <td class="mid-align"><%=c.getCategoryId() %></td>
      <td class="mid-align"><%=c.getCategoryTitle() %></td>
      <td class="mid-align"><%=c.getCategoryDescription() %></td>
      <td class="mid-align"><a href="ProductOperationServlet?categoryId=<%=c.getCategoryId()%>&action=deleteCategory"><input type="submit" class="btn btn-danger" value="Delete"></a></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

<!-- ********************* -->

<!-- show Product modal -->

<div class="modal fade" id="show-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Product</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Product Name</th>
      <th scope="col">Product Image</th>
      <th scope="col">Product Description</th>
      <th scope="col">Product Category</th>
      <th scope="col">Product Price</th>
      <th scope="col">Product Discount</th>
      <th scope="col">Product Quantity</th>
    </tr>
  </thead>
  <tbody>
   <%
      ProductDaoImp pd=new ProductDaoImp();
      List<Product> lp=pd.getAllProduct();
      CategoryDaoImp c=new CategoryDaoImp();
   %>
  
   <%
      for(Product p:lp)
      {
   %>
    <tr>
      <td class="mid-align"><%=p.getProductTitle() %></td>
      <td class="mid-align"><img style="max-width:70px" class="img-fluid" src="productImages/<%=p.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getProductDescription()%></td>
       <td class="mid-align"><%=c.getCategoryNameById(p.getCategoryId()) %></td>
      <td class="mid-align"><%=p.getProductPrice() %></td>
      <td class="mid-align"><%=p.getProductDiscount() %></td>
      <td class="mid-align"><%=p.getProductQuantity() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

<!-- ********************* -->


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
    <!-- Footer End -->
<!--  -->
  
</body>
</html>