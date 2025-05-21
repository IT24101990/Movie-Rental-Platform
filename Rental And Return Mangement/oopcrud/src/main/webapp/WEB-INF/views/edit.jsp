<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Rental</title>
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
            background-color: #10b981;
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
    </style>
</head>
<body class="bg-gray-50">
<div class="hidden toast" id="successToast">
    <div class="flex items-center space-x-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
        </svg>
        <span>Rental updated successfully!</span>
    </div>
</div>

<div class="max-w-2xl mx-auto p-4 sm:p-6 lg:p-8">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-semibold text-gray-900">Edit Rental</h1>
        <a href="/" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-gray-600 hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Back
        </a>
    </div>

    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
        <form id="rentalForm" class="p-6 space-y-6">
            <!-- Hidden ID field for PUT request -->
            <input type="hidden" id="rentalId" name="rentalId" value="${rend.id}">

            <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                <!-- Movie Name -->
                <div class="sm:col-span-2">
                    <label for="movieName" class="block text-sm font-medium text-gray-700">Movie Name</label>
                    <div class="mt-1">
                        <input type="text" id="movieName" name="movieName" required value="${rend.movieName}"
                               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="movieNameError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid movie name (at least 2 characters)</p>
                </div>

                <!-- Customer Name -->
                <div class="sm:col-span-2">
                    <label for="customerName" class="block text-sm font-medium text-gray-700">Customer Name</label>
                    <div class="mt-1">
                        <input type="text" id="customerName" name="customerName" required value="${rend.customerName}"
                               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="customerNameError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid customer name (at least 2 characters)</p>
                </div>

                <!-- Rented Date -->
                <div>
                    <label for="rentedDate" class="block text-sm font-medium text-gray-700">Rental Date</label>
                    <div class="mt-1">
                        <input type="date" id="rentedDate" name="rentedDate" required value="${rend.rentedDate}"
                               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="rentedDateError" class="mt-1 text-sm text-red-600 hidden">Please select a valid date</p>
                </div>

                <!-- Rented Time -->
                <div>
                    <label for="rentedTime" class="block text-sm font-medium text-gray-700">Rental Time</label>
                    <div class="mt-1">
                        <input type="time" id="rentedTime" name="rentedTime" required value="${rend.rentedTime}"
                               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="rentedTimeError" class="mt-1 text-sm text-red-600 hidden">Please select a valid time</p>
                </div>

                <!-- Price -->
                <div>
                    <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="text-gray-500 sm:text-sm">$</span>
                        </div>
                        <input type="number" step="0.01" min="0" id="price" name="price" required value="${rend.price}"
                               class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="priceError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid price (greater than 0)</p>
                </div>

                <!-- Status -->
                <div>
                    <label for="status" class="block text-sm font-medium text-gray-700">Status</label>
                    <div class="mt-1">
                        <select id="status" name="status" required
                                class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                            <option value="">Select status</option>
                            <option value="RENTED" ${rend.status == 'RENTED' ? 'selected' : ''}>RENTED</option>
                            <option value="RETURNED" ${rend.status == 'RETURNED' ? 'selected' : ''}>RETURNED</option>
                            <option value="OVERDUE" ${rend.status == 'OVERDUE' ? 'selected' : ''}>OVERDUE</option>
                        </select>
                    </div>
                    <p id="statusError" class="mt-1 text-sm text-red-600 hidden">Please select a status</p>
                </div>

                <!-- Fine (initially hidden, shown when status is RETURNED or OVERDUE) -->
                <div id="fineContainer" class="${rend.status == 'RETURNED' || rend.status == 'OVERDUE' ? '' : 'hidden'}">
                    <label for="fine" class="block text-sm font-medium text-gray-700">Fine</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="text-gray-500 sm:text-sm">$</span>
                        </div>
                        <input type="number" step="0.01" min="0" id="fine" name="fine" value="${rend.fine}"
                               class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 sm:text-sm border-gray-300 rounded-md px-3 py-2 border">
                    </div>
                    <p id="fineError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid fine amount</p>
                </div>

                <!-- Contact Number -->
                <div class="${rend.status == 'RETURNED' || rend.status == 'OVERDUE' ? '' : 'sm:col-span-2'}">
                    <label for="contactNumber" class="block text-sm font-medium text-gray-700">Contact Number</label>
                    <div class="mt-1">
                        <input type="tel" id="contactNumber" name="contactNumber" required value="${rend.contactNumber}"
                               class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md px-3 py-2 border"
                               placeholder="e.g., 0123456789">
                    </div>
                    <p id="contactNumberError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid phone number (10 digits starting with 0)</p>
                </div>
            </div>

            <div class="pt-5">
                <div class="flex justify-end">
                    <button type="button" id="cancelBtn" class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 mr-3">
                        Cancel
                    </button>
                    <button type="submit" class="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Update Rental
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('rentalForm');
        const cancelBtn = document.getElementById('cancelBtn');
        const successToast = document.getElementById('successToast');
        const statusSelect = document.getElementById('status');
        const fineContainer = document.getElementById('fineContainer');
        const rentalId = document.getElementById('rentalId').value;
        const contactNumberContainer = document.getElementById('contactNumber').parentElement.parentElement;

        // Regular expressions for validation
        const validations = {
            movieName: {
                regex: /.{2,}/,
                errorId: 'movieNameError',
                message: 'Please enter a valid movie name (at least 2 characters)'
            },
            customerName: {
                regex: /.{2,}/,
                errorId: 'customerNameError',
                message: 'Please enter a valid customer name (at least 2 characters)'
            },
            contactNumber: {
                regex: /^0\d{9}$/,
                errorId: 'contactNumberError',
                message: 'Please enter a valid phone number (10 digits starting with 0)'
            },
            price: {
                regex: /^(?!0$)\d+(\.\d{1,2})?$/,
                errorId: 'priceError',
                message: 'Please enter a valid price (greater than 0)'
            },
            fine: {
                regex: /^\d+(\.\d{1,2})?$/,
                errorId: 'fineError',
                message: 'Please enter a valid fine amount'
            }
        };

        // Format phone number as user types
        const contactNumberInput = document.getElementById('contactNumber');
        contactNumberInput.addEventListener('input', function(e) {
            // Remove all non-digit characters
            let value = e.target.value.replace(/\D/g, '');
            // Limit to 10 digits
            value = value.slice(0, 10);
            e.target.value = value;
        });

        // Show/hide fine field based on status
        statusSelect.addEventListener('change', function() {
            if (this.value === 'RETURNED' || this.value === 'OVERDUE') {
                fineContainer.classList.remove('hidden');
                // Change contact number to only take half width
                contactNumberContainer.classList.remove('sm:col-span-2');
            } else {
                fineContainer.classList.add('hidden');
                // Change contact number to take full width
                contactNumberContainer.classList.add('sm:col-span-2');
            }
        });

        // Validate input fields
        const validateField = (field, value) => {
            const validation = validations[field];
            if (!validation) return true;

            const errorElement = document.getElementById(validation.errorId);
            if (!validation.regex.test(value)) {
                errorElement.textContent = validation.message;
                errorElement.classList.remove('hidden');
                return false;
            }

            errorElement.classList.add('hidden');
            return true;
        };

        // Add validation to inputs
        for (const field in validations) {
            const input = document.getElementById(field);
            if (input) {
                input.addEventListener('input', (e) => {
                    validateField(field, e.target.value);
                });
                input.addEventListener('blur', (e) => {
                    validateField(field, e.target.value);
                });
            }
        }

        // Handle form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            // Get form data
            let isValid = true;
            const formFields = ['movieName', 'customerName', 'rentedDate', 'rentedTime', 'price', 'status', 'contactNumber'];

            const formData = {};
            formFields.forEach(field => {
                const input = document.getElementById(field);
                formData[field] = input.value;

                // Validate required fields
                if (!input.value) {
                    const errorId = `${field}Error`;
                    if (document.getElementById(errorId)) {
                        document.getElementById(errorId).textContent = 'This field is required';
                        document.getElementById(errorId).classList.remove('hidden');
                    }
                    isValid = false;
                    return;
                }

                // Validate with regex if applicable
                if (validations[field] && !validateField(field, input.value)) {
                    isValid = false;
                    return;
                }
            });

            // Add fine field if status is RETURNED or OVERDUE
            if (formData.status === 'RETURNED' || formData.status === 'OVERDUE') {
                const fineInput = document.getElementById('fine');
                if (fineInput) {
                    formData.fine = parseFloat(fineInput.value) || 0.0;

                    // Validate fine field
                    if (!validateField('fine', fineInput.value)) {
                        isValid = false;
                    }
                }
            } else {
                // Set default fine to 0.0 for other statuses
                formData.fine = 0.0;
            }

            if (!isValid) return;

            // Send data to the server
            fetch(`/api/rentals/`+rentalId, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Server responded with status ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    // Show success message
                    successToast.classList.remove('hidden');
                    successToast.classList.add('show');

                    // Navigate to home page after a delay
                    setTimeout(() => {
                        window.location.href = '/';
                    }, 1500);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while updating the rental. Please try again.');
                });
        });

        // Cancel button redirects to home
        cancelBtn.addEventListener('click', function() {
            window.location.href = '/';
        });
    });
</script>
</body>
</html>