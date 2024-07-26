<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="constant.ESubjectStatus"%>
<%
    request.setAttribute("statuses", ESubjectStatus.values());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Add A New Subject</title>
    <!-- Meta tags and CSS links -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- favicon -->
    <link rel="shortcut icon" href="../assets/images/favicon.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Date picker -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <jsp:include page="../loader/loader.jsp"/>
    <div class="page-wrapper doctris-theme toggled">
        <jsp:include page="../navbar/vertical.jsp"/>
        <main class="page-content bg-light">
            <jsp:include page="../navbar/horizontal.jsp"/>
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="d-md-flex justify-content-between">
                        <h5 class="mb-0">Add New Subject</h5>
                        <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                            <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/all-subjects">All Subjects</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Add Subject</li>
                            </ul>
                        </nav>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 mt-4">
                            <div class="card border-0 p-4 rounded shadow">
                                <form class="mt-4" action="${pageContext.request.contextPath}/subject/add" method="post">
                                    <div class="row">
                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Name*</label>
                                                <input name="name" id="name" type="text" class="form-control" placeholder="Name :" value="${nameValue}">
                                                <c:if test="${not empty nameError}">
                                                    <small class="text-danger">${nameError}</small>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Code*</label>
                                                <input name="code" id="code" type="text" class="form-control" placeholder="Code :" value="${codeValue}">
                                                <c:if test="${not empty codeError}">
                                                    <small class="text-danger">${codeError}</small>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Description*</label>
                                                <textarea name="description" class="form-control" placeholder="Description :">${descriptionValue}</textarea>
                                                <c:if test="${not empty descriptionError}">
                                                    <small class="text-danger">${descriptionError}</small>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Note*</label>
                                                <textarea name="note" class="form-control" placeholder="Note :">${noteValue}</textarea>
                                                <c:if test="${not empty noteError}">
                                                    <small class="text-danger">${noteError}</small>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Category*</label>
                                                <select class="form-select" name="category">
                                                    <c:forEach var="cate" items="${categories}">
                                                        <option value="${cate.id}">${cate.name}</option>
                                                    </c:forEach>
                                                </select>
                                                <c:if test="${not empty categoryError}">
                                                    <small class="text-danger">${categoryError}</small>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-6 my-2">
                                            <div class="form-group">
                                                <label class="form-label">Status*</label>
                                                <div class="form-check">
                                                    <c:forEach var="status" items="${statuses}">
                                                        <input class="form-check-input" type="radio" name="status" id="${status}" value="${status.name()}" <c:if test="${status.name() == statusValue}">checked</c:if>>
                                                        <label class="form-check-label" for="${status}">
                                                            ${status.subjectStatus}
                                                        </label><br/>
                                                    </c:forEach>
                                                    <c:if test="${not empty statusError}">
                                                        <small class="text-danger">${statusError}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12 mt-1 mb-4">
                                            <label class="form-label">Manager*</label>
                                            <select class="form-select" name="managerIds" multiple aria-label="Multiple select example">
                                                <c:forEach var="mana" items="${managers}">
                                                    <option value="${mana.id}">${mana.fullName}</option>
                                                </c:forEach>
                                            </select>
                                            <c:if test="${not empty managerError}">
                                                <small class="text-danger">${managerError}</small>
                                            </c:if>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Add Subject</button>
                                    <button type="reset" class="btn btn-secondary">Cancel</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../footer/footer.jsp"/>
        </main>
    </div>
    <!-- JavaScript files -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <!-- Select2 -->
    <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/select2.init.js"></script>
    <!-- Datepicker -->
    <script src="${pageContext.request.contextPath}/assets/js/flatpickr.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flatpickr.init.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script>
        const currentSite = '${currentSite}';
    </script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
