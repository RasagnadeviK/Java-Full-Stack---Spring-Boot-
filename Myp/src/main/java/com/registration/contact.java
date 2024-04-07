package com.registration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class contact
 */
@WebServlet("/contact")
public class contact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String cname = request.getParameter("name");
		String cemail = request.getParameter("email");
		String csubject = request.getParameter("subject");
		String cmessage = request.getParameter("message");

		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		if(cname == null || cname.equals("")) {
			request.setAttribute("status", "invaliduname");
			dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
		}
		if(cemail == null || cemail.equals("")) {
			request.setAttribute("status", "invaliduemail");
			dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
		}
		if(csubject == null || csubject.equals("")) {
			request.setAttribute("status", "invalidupwd");
			dispatcher = request.getRequestDispatcher("index.jsp");
			dispatcher.forward(request, response);
		}
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/emp?useSSL=false","root","Deepak_992019");
			PreparedStatement pst = con.prepareStatement("insert into contact(cname,cemail,csubject,cmessage)values(?,?,?,?)");
			pst.setString(1, cname);
			pst.setString(2, cemail);
			pst.setString(3, csubject);
			pst.setString(4, cmessage);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("index.jsp");
			
			if(rowCount >0) {
				request.setAttribute("status", "success");
				
			}
			else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		
		}
		finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
	}

}