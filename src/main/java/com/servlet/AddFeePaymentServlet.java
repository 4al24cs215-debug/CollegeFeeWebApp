package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddFeePaymentServlet")
public class AddFeePaymentServlet extends HttpServlet {
    private FeePaymentDAO feePaymentDAO;
    
    public void init() {
        feePaymentDAO = new FeePaymentDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            String studentName = request.getParameter("studentName");
            String paymentDateStr = request.getParameter("paymentDate");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String status = request.getParameter("status");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = sdf.parse(paymentDateStr);
            
            FeePayment payment = new FeePayment();
            payment.setStudentId(studentId);
            payment.setStudentName(studentName);
            payment.setPaymentDate(paymentDate);
            payment.setAmount(amount);
            payment.setStatus(status);
            
            boolean success = feePaymentDAO.addFeePayment(payment);
            
            if (success) {
                request.setAttribute("message", "Fee payment added successfully!");
            } else {
                request.setAttribute("error", "Failed to add fee payment!");
            }
            
            request.getRequestDispatcher("feepaymentadd.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("feepaymentadd.jsp").forward(request, response);
        }
    }
}