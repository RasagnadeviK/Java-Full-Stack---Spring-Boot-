package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ecommerce.pojo.Cart;
import com.ecommerce.dao.CartDaoImp;
import com.ecommerce.dao.OrderDaoImp;
import com.ecommerce.dao.Helper;
import com.ecommerce.dao.ProductDaoImp;
import com.ecommerce.dao.UserDaoImp;
import com.ecommerce.dbUtility.DBUtility;
import com.ecommerce.pojo.Cart;
import com.ecommerce.pojo.Order;
import com.ecommerce.pojo.Product;
import com.ecommerce.pojo.User;
@WebServlet("/place_cod_order")
public class CashServlet extends HttpServlet {
	PreparedStatement stmt;
    ResultSet rs;
    int row=0,count=0;
	    private static final long serialVersionUID = 1L;

	    public void AuthorizePaymentServlet() {
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String userId = (String) request.getParameter("userId");
	        System.out.println("User Id: " + userId);
	        List<Cart> listOfproductInCart = new CartDaoImp().getCartByUserId(Integer.parseInt(userId));

	        // Calculate the total price of items in the cart
	        double totalPrice = calculateTotalPrice(listOfproductInCart);

	        // For Cash on Delivery, you might generate a confirmation page or proceed directly
	        // Generate an order confirmation page or process the order directly for Cash on Delivery
	        // ...

	        // Insert cart items into the order table
	        boolean orderInserted = insertOrderItems(userId, listOfproductInCart);

	        if (orderInserted) {
	            request.setAttribute("totalPrice", totalPrice);
	            request.setAttribute("cartItems", listOfproductInCart);
	            String successMessage = "Order placed successfully!";
	            response.getWriter().write(successMessage);
	        } else {
	            // Handle the case where the order insertion failed
	            // Provide an error message or redirect to an error page
	        }
	    }

	    // Method to insert cart items into the order table
	    private boolean insertOrderItems(String userId, List<Cart> cartItems) {
	        OrderDaoImp orderDao = new OrderDaoImp();
	        boolean orderInserted = false;

	        for (Cart cart : cartItems) {
	            Order order = new Order();
	            order.setUserId(Integer.parseInt(userId));
	            order.setProdctId(cart.getProductId());
	            order.setQuantity(cart.getQuantity());
	            order.setPrice(cart.getPrice());
	            order.setOrderesDate(Helper.getCurrentDate());
	            order.setDeliveryDate(Helper.getDeliveryDate());

	            // Insert order into the database
	            orderInserted = orderDao.addOrder(order);

	            if (!orderInserted) {
	                // If one insertion fails, stop and return false
	                break;
	            }
	        }
	        return orderInserted;
	    }

	    // Method to calculate total price from cart items
	    private double calculateTotalPrice(List<Cart> cartItems) {
	        // Logic to calculate total price
	        // Iterate through cart items and sum up the prices
	        double totalPrice = 0.0;
	        for (Cart cart : cartItems) {
	            totalPrice += cart.getPrice(); // Consider updating this according to your cart structure
	        }
	        return totalPrice;
	    }
	   
	}
