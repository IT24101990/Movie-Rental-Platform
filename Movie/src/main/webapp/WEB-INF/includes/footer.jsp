<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  html {
    height: 100%;
  }
  
  body {
    min-height: 100%;
    display: flex;
    flex-direction: column;
  }

  .content-wrapper {
    flex: 1 0 auto;
  }

  footer {
    background: linear-gradient(to bottom, #031f3a, #123359);
    color: #ffffff;
    flex-shrink: 0;
  }

  footer h5 {
    color: #ffffff;
    font-weight: bold;
  }

  footer a {
    color: #ffffff !important;
    transition: color 0.3s ease;
  }

  footer a:hover {
    color: #ffffff !important;
    text-decoration: none;
  }

  footer .border-top {
    border-top-color: #ffffff !important;
  }

  footer i {
    color: #ffffff;
  }
</style>

<footer class="py-4 mt-auto">
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-4">
        <h5 class="mb-3">Movie Rental</h5>
        <p class="text-light" style="font-size: 0.9rem;">
          Your one-stop destination for renting the latest and greatest movies. Enjoy from the comfort of your home.
        </p>
      </div>


      <div class="col-md-4 mb-4">
        <h5 class="mb-3">Quick Links</h5>
        <ul class="list-unstyled">
          <li class="mb-2">
            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">Movies</a>
          </li>
        </ul>
      </div>

      <div class="col-md-4 mb-4">
        <h5 class="mb-3">Contact Us</h5>
        <ul class="list-unstyled">
          <li class="mb-2">
            <i class="bi bi-geo-alt-fill me-2"></i>
            SLIIT Malabe Campus, New Kandy Rd, Malabe.
          </li>
          <li class="mb-2">
            <i class="bi bi-telephone-fill me-2"></i>
            (012) 345-6789
          </li>
          <li class="mb-2">
            <i class="bi bi-envelope-fill me-2"></i>
            info@movierentalapp.com
          </li>
        </ul>
      </div>
    </div>
  </div>
  <div class="text-center pt-3 mt-3 border-top">
    <p class="mb-0" style="font-size: 0.9rem;">&copy; 2023 Movie Rental. All rights reserved.</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>