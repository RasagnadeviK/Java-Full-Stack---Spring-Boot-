package com.ecommerce.servlet;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.ecommerce.dbUtility.DBUtility;

import java.io.*;
import java.sql.*;
@WebServlet("/Organizationservlet")
public class Organizationservlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("organizationname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");


        try {
            
            // Establish connection
            Connection con=DBUtility.getConnection();
            
            // Prepare SQL statement
            String sql = "INSERT INTO organizarion(name, email, phone, message) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, message);
            
            // Execute the statement
            int rowsInserted = statement.executeUpdate();
            String twilioAccountSid = "AC63293127cef9d02e3ccd10e0cf16c034";
            String twilioAuthToken = "2169328f2dec3041f909d2495524b5cd";
            String twilioPhoneNumber = "+1 414 269 4300";
            String toPhoneNumber = "+918074190480"; // Replace with the recipient's phone number

            Twilio.init(twilioAccountSid, twilioAuthToken);

            // Constructing the message
            String smsBody = "New submission from: " + name + ". Email: " + email + ". Phone: " + phone + ". Message: " + message;

            Message twilioMessage = Message.creator(
                    new PhoneNumber(toPhoneNumber),
                    new PhoneNumber(twilioPhoneNumber),
                    smsBody).create();

            System.out.println("SMS sent! SID: " + twilioMessage.getSid());
            if (rowsInserted > 0) {
                // Successful insertion
                request.setAttribute("submissionStatus", "success");
            } else {
                // Error handling
                request.setAttribute("submissionStatus", "error");
            }
            request.getRequestDispatcher("organization.jsp").forward(request, response);

            
            // Close connection
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Redirect to an error page
            response.sendRedirect("organization.jsp");
        }
    }
}
