<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Rental Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Inter font for shadcn-like look -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .toast {
            position: fixed;
            top: 1rem;
            right: 1rem;
            padding: 1rem;
            color: white;
            border-radius: 0.375rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            z-index: 50;
            transform: translateY(-100%);
            opacity: 0;
            transition: all 0.3s ease-out;
        }
        .toast.show {
            transform: translateY(0);
            opacity: 1;
        }
        .toast.success {
            background-color: #10b981;
        }
        .toast.error {
            background-color: #ef4444;
        }
        .skeleton {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: .5;
            }
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            z-index: 10;
            margin-top: 0.5rem;
            background-color: white;
            border-radius: 0.375rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            width: 12rem;
        }
        .dropdown-menu.show {
            display: block;
        }
    </style>
</head>
<body class="bg-gray-50">
<div id="toast" class="hidden toast">
    <div class="flex items-center space-x-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
        </svg>
        <span id="toastMessage"></span>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed z-10 inset-0 overflow-y-auto hidden">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 transition-opacity" aria-hidden="true">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                <div class="sm:flex sm:items-start">
                    <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
                        <svg class="h-6 w-6 text-red-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">Delete Rental</h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-500">Are you sure you want to delete this rental? This action cannot be undone.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <button type="button" id="confirmDelete" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Delete
                </button>
                <button type="button" id="cancelDelete" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="sm:flex sm:items-center mb-6">
        <div class="sm:flex-auto">
            <h1 class="text-2xl font-semibold text-gray-900">Movie Rentals</h1>
            <p class="mt-2 text-sm text-gray-700">A list of all movie rentals in your system.</p>
        </div>
        <div class="mt-4 sm:mt-0 sm:ml-16 sm:flex-none">
            <a href="/create" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                </svg>
                Add Rental
            </a>
        </div>
    </div>

    <div class="flex flex-col">
        <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
                <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 md:rounded-lg min-h-[500px]">
                    <table class="min-w-full divide-y divide-gray-300">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Movie</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Customer</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Rental Date</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Price</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Status</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Contact</th>
                            <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-6">
                                <span class="sr-only">Actions</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="rentalsTableBody" class="divide-y divide-gray-200 bg-white">
                        <!-- Skeleton loading rows -->
                        <tr class="skeleton">
                            <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                                <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/2"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/2"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-5 bg-gray-200 rounded w-20"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-8 bg-gray-200 rounded w-8"></div>
                            </td>
                        </tr>
                        <tr class="skeleton">
                            <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                                <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/2"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/2"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-1/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-5 bg-gray-200 rounded w-20"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                            </td>
                            <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                <div class="h-8 bg-gray-200 rounded w-8"></div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!-- No rentals message -->
                <div id="noRentalsMessage" class="hidden text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">No rentals found</h3>
                    <p class="mt-1 text-sm text-gray-500">Get started by creating a new rental.</p>
                    <div class="mt-6">
                        <a href="/create" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                            </svg>
                            New Rental
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        let currentDeleteId = null;
        const rentalsTableBody = document.getElementById("rentalsTableBody");
        const noRentalsMessage = document.getElementById("noRentalsMessage");
        const toast = document.getElementById("toast");
        const toastMessage = document.getElementById("toastMessage");
        const deleteModal = document.getElementById("deleteModal");
        const confirmDeleteBtn = document.getElementById("confirmDelete");
        const cancelDeleteBtn = document.getElementById("cancelDelete");

        // Load rentals on page load
        loadRentals();

        // Handle confirm delete action
        confirmDeleteBtn.addEventListener("click", function() {
            if (currentDeleteId) {
                deleteRental(currentDeleteId);
                hideModal();
            }
        });

        // Handle cancel delete action
        cancelDeleteBtn.addEventListener("click", hideModal);

        function hideModal() {
            deleteModal.classList.add("hidden");
            currentDeleteId = null;
        }

        function showToast(message, type) {
            toastMessage.textContent = message;
            toast.classList.remove("hidden", "success", "error");
            toast.classList.add("show", type);

            setTimeout(function() {
                toast.classList.remove("show");
                setTimeout(function() {
                    toast.classList.add("hidden");
                }, 300);
            }, 3000);
        }

        function loadRentals() {
            fetch("/api/rentals")
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.json();
                })
                .then(function(data) {
                    // Clear loading skeletons
                    rentalsTableBody.innerHTML = "";

                    if (data.length === 0) {
                        noRentalsMessage.classList.remove("hidden");
                    } else {
                        noRentalsMessage.classList.add("hidden");

                        // Add rentals to table
                        data.forEach(function(rental) {
                            addRentalToTable(rental);
                        });
                    }
                })
                .catch(function(error) {
                    console.error("Error loading rentals:", error);
                    showToast("Failed to load rentals. Please try again.", "error");
                });
        }

        function addRentalToTable(rental) {
            const row = document.createElement("tr");
            row.className = "hover:bg-gray-50";
            row.dataset.id = rental.id;

            // Format date for display
            const rentedDate = rental.rentedDate;
            const rentedTime = rental.rentedTime;

            // Format status badge
            let statusColor = "";
            switch(rental.status) {
                case "RENTED":
                    statusColor = "bg-yellow-100 text-yellow-800";
                    break;
                case "RETURNED":
                    statusColor = "bg-green-100 text-green-800";
                    break;
                case "OVERDUE":
                    statusColor = "bg-red-100 text-red-800";
                    break;
                default:
                    statusColor = "bg-gray-100 text-gray-800";
            }

            row.innerHTML =
                "<td class=\"whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6\">" +
                rental.movieName +
                "</td>" +
                "<td class=\"whitespace-nowrap px-3 py-4 text-sm text-gray-500\">" +
                rental.customerName +
                "</td>" +
                "<td class=\"whitespace-nowrap px-3 py-4 text-sm text-gray-500\">" +
                rentedDate + " " + rentedTime +
                "</td>" +
                "<td class=\"whitespace-nowrap px-3 py-4 text-sm text-gray-500\">" +
                "$" + rental.price.toFixed(2) +
                "</td>" +
                "<td class=\"whitespace-nowrap px-3 py-4 text-sm\">" +
                "<span class=\"inline-flex rounded-full px-2 text-xs font-semibold leading-5 " + statusColor + "\">" +
                rental.status +
                "</span>" +
                "</td>" +
                "<td class=\"whitespace-nowrap px-3 py-4 text-sm text-gray-500\">" +
                rental.contactNumber +
                "</td>" +
                "<td class=\"relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6\">" +
                "<div class=\"inline-block relative\">" +
                "<button type=\"button\" class=\"dropdown-trigger text-gray-400 hover:text-gray-500 focus:outline-none\">" +
                "<span class=\"sr-only\">Open options</span>" +
                "<svg class=\"h-5 w-5\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 20 20\" fill=\"currentColor\" aria-hidden=\"true\">" +
                "<path d=\"M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z\" />" +
                "</svg>" +
                "</button>" +
                "<div class=\"dropdown-menu\" data-id=\"" + rental.id + "\">" +
                "<a href=\"/edit/" + rental.id + "\" class=\"block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 focus:outline-none focus:bg-gray-100 focus:text-gray-900\">" +
                "Edit" +
                "</a>" +
                "<button type=\"button\" class=\"delete-btn block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-100 hover:text-red-700 focus:outline-none focus:bg-gray-100 focus:text-red-700\">" +
                "Delete" +
                "</button>" +
                "</div>" +
                "</div>" +
                "</td>";

            rentalsTableBody.appendChild(row);

            // Add event listener to dropdown trigger
            const dropdownTrigger = row.querySelector(".dropdown-trigger");
            const dropdownMenu = row.querySelector(".dropdown-menu");
            const deleteBtn = row.querySelector(".delete-btn");

            dropdownTrigger.addEventListener("click", function(e) {
                e.stopPropagation();

                // Close all other dropdown menus
                document.querySelectorAll(".dropdown-menu.show").forEach(function(menu) {
                    if (menu !== dropdownMenu) {
                        menu.classList.remove("show");
                    }
                });

                // Toggle this dropdown menu
                dropdownMenu.classList.toggle("show");
            });

            // Add delete button event listener
            deleteBtn.addEventListener("click", function() {
                const id = dropdownMenu.dataset.id;
                showDeleteConfirmation(id);
            });
        }

        function showDeleteConfirmation(id) {
            currentDeleteId = id;
            deleteModal.classList.remove("hidden");
        }

        function deleteRental(id) {
            fetch("/api/rentals/" + id, {
                method: "DELETE"
            })
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error("Failed to delete rental");
                    }

                    // Remove row from table
                    const row = document.querySelector("tr[data-id='" + id + "']");
                    if (row) {
                        row.remove();
                    }

                    // Show success message
                    showToast("Rental deleted successfully", "success");

                    // Check if table is now empty
                    if (rentalsTableBody.children.length === 0) {
                        noRentalsMessage.classList.remove("hidden");
                    }
                })
                .catch(function(error) {
                    console.error("Error deleting rental:", error);
                    showToast("Failed to delete rental", "error");
                });
        }

        // Close all dropdowns when clicking outside
        document.addEventListener("click", function() {
            document.querySelectorAll(".dropdown-menu.show").forEach(function(menu) {
                menu.classList.remove("show");
            });
        });
    });
</script>
</body>
</html>