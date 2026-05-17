package com.servlet;

import com.dao.FeePaymentDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteFeePaymentServlet")
public class DeleteFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO feePaymentDAO;
    
    public void init() {
        feePaymentDAO = new FeePaymentDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            boolean success = feePaymentDAO.deleteFeePayment(paymentId);
            
            if (success) {
                request.setAttribute("message", "Fee payment deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete fee payment!");
            }
            
            request.getRequestDispatcher("feepaymentdelete.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("feepaymentdelete.jsp").forward(request, response);
        }
    }
}