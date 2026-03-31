-- CreateEnum
CREATE TYPE "PriorityLevel" AS ENUM ('Low', 'Medium', 'High');

-- CreateEnum
CREATE TYPE "Category" AS ENUM ('Complain', 'Maintenance', 'Other');

-- CreateEnum
CREATE TYPE "ServiceStatus" AS ENUM ('Pending', 'Ongoing', 'Resolved');

-- CreateEnum
CREATE TYPE "InvoiceStatus" AS ENUM ('Overdue', 'Paid', 'Pending');

-- CreateEnum
CREATE TYPE "RelationshipToTenant" AS ENUM ('SPOUSE', 'PARENT', 'CHILD', 'SIBLING', 'RELATIVE', 'FRIEND', 'OTHER');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('Cash', 'Mobile_Banking');

-- CreateEnum
CREATE TYPE "RoomStatus" AS ENUM ('Available', 'Rented', 'Purchased', 'InMaintenance');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('Tenant', 'Admin', 'Staff');

-- CreateTable
CREATE TABLE "bills" (
    "id" TEXT NOT NULL,
    "rentalFee" DECIMAL(65,30) NOT NULL,
    "electricityFee" DECIMAL(65,30) NOT NULL,
    "waterFee" DECIMAL(65,30) NOT NULL,
    "fineFee" DECIMAL(65,30),
    "serviceFee" DECIMAL(65,30),
    "groundFee" DECIMAL(65,30) NOT NULL,
    "carParkingFee" DECIMAL(65,30),
    "wifiFee" DECIMAL(65,30),
    "totalAmount" DECIMAL(65,30) NOT NULL,
    "dueDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "roomId" TEXT NOT NULL,

    CONSTRAINT "bills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contracts" (
    "id" TEXT NOT NULL,
    "expiryDate" TIMESTAMP(3) NOT NULL,
    "createdDate" TIMESTAMP(3) NOT NULL,
    "updatedDate" TIMESTAMP(3),
    "roomId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "contractTypeId" TEXT NOT NULL,

    CONSTRAINT "contracts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contract_types" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "duration" INTEGER NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "facilities" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "contract_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_services" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" "Category" NOT NULL,
    "status" "ServiceStatus" NOT NULL,
    "priorityLevel" "PriorityLevel" NOT NULL,
    "issuedDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "roomId" TEXT NOT NULL,

    CONSTRAINT "customer_services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoices" (
    "id" TEXT NOT NULL,
    "invoiceNo" TEXT NOT NULL,
    "status" "InvoiceStatus" NOT NULL,
    "receiptSent" BOOLEAN NOT NULL DEFAULT false,
    "billId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "invoices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "occupants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "nrc" TEXT,
    "relationshipToTenant" "RelationshipToTenant" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "tenantId" TEXT NOT NULL,

    CONSTRAINT "occupants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receipts" (
    "id" TEXT NOT NULL,
    "paymentMethod" "PaymentMethod" NOT NULL DEFAULT 'Cash',
    "paidDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "invoiceId" TEXT NOT NULL,

    CONSTRAINT "receipts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rooms" (
    "id" TEXT NOT NULL,
    "roomNo" INTEGER NOT NULL,
    "floor" INTEGER NOT NULL,
    "dimension" TEXT NOT NULL,
    "noOfBedRoom" INTEGER NOT NULL,
    "status" "RoomStatus" NOT NULL DEFAULT 'Available',
    "sellingPrice" DECIMAL(65,30),
    "maxNoOfPeople" INTEGER NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "rooms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "nrc" TEXT NOT NULL,
    "phoneNo" TEXT NOT NULL,
    "emergencyNo" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "roomId" TEXT NOT NULL,

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "total_units" (
    "id" TEXT NOT NULL,
    "electricityUnits" DECIMAL(65,30) NOT NULL,
    "waterUnits" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "billId" TEXT NOT NULL,

    CONSTRAINT "total_units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "refreshToken" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "tenantId" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "bills_roomId_idx" ON "bills"("roomId");

-- CreateIndex
CREATE INDEX "bills_dueDate_idx" ON "bills"("dueDate");

-- CreateIndex
CREATE INDEX "bills_roomId_dueDate_idx" ON "bills"("roomId", "dueDate");

-- CreateIndex
CREATE UNIQUE INDEX "contracts_roomId_key" ON "contracts"("roomId");

-- CreateIndex
CREATE UNIQUE INDEX "contracts_tenantId_key" ON "contracts"("tenantId");

-- CreateIndex
CREATE INDEX "contracts_tenantId_idx" ON "contracts"("tenantId");

-- CreateIndex
CREATE INDEX "contracts_roomId_idx" ON "contracts"("roomId");

-- CreateIndex
CREATE INDEX "contracts_expiryDate_idx" ON "contracts"("expiryDate");

-- CreateIndex
CREATE INDEX "contracts_tenantId_expiryDate_idx" ON "contracts"("tenantId", "expiryDate");

-- CreateIndex
CREATE INDEX "contract_types_name_idx" ON "contract_types"("name");

-- CreateIndex
CREATE INDEX "customer_services_roomId_idx" ON "customer_services"("roomId");

-- CreateIndex
CREATE INDEX "customer_services_status_priorityLevel_idx" ON "customer_services"("status", "priorityLevel");

-- CreateIndex
CREATE INDEX "customer_services_category_status_idx" ON "customer_services"("category", "status");

-- CreateIndex
CREATE INDEX "customer_services_createdAt_idx" ON "customer_services"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "invoices_invoiceNo_key" ON "invoices"("invoiceNo");

-- CreateIndex
CREATE UNIQUE INDEX "invoices_billId_key" ON "invoices"("billId");

-- CreateIndex
CREATE INDEX "invoices_billId_idx" ON "invoices"("billId");

-- CreateIndex
CREATE INDEX "invoices_status_createdAt_idx" ON "invoices"("status", "createdAt");

-- CreateIndex
CREATE INDEX "invoices_status_receiptSent_idx" ON "invoices"("status", "receiptSent");

-- CreateIndex
CREATE INDEX "occupants_tenantId_idx" ON "occupants"("tenantId");

-- CreateIndex
CREATE INDEX "occupants_tenantId_relationshipToTenant_idx" ON "occupants"("tenantId", "relationshipToTenant");

-- CreateIndex
CREATE UNIQUE INDEX "receipts_invoiceId_key" ON "receipts"("invoiceId");

-- CreateIndex
CREATE INDEX "receipts_invoiceId_idx" ON "receipts"("invoiceId");

-- CreateIndex
CREATE INDEX "receipts_paidDate_idx" ON "receipts"("paidDate");

-- CreateIndex
CREATE UNIQUE INDEX "rooms_roomNo_key" ON "rooms"("roomNo");

-- CreateIndex
CREATE INDEX "rooms_roomNo_idx" ON "rooms"("roomNo");

-- CreateIndex
CREATE INDEX "rooms_status_floor_idx" ON "rooms"("status", "floor");

-- CreateIndex
CREATE INDEX "rooms_status_createdAt_idx" ON "rooms"("status", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_roomId_key" ON "tenants"("roomId");

-- CreateIndex
CREATE INDEX "tenants_email_idx" ON "tenants"("email");

-- CreateIndex
CREATE INDEX "tenants_nrc_idx" ON "tenants"("nrc");

-- CreateIndex
CREATE INDEX "tenants_phoneNo_idx" ON "tenants"("phoneNo");

-- CreateIndex
CREATE INDEX "tenants_roomId_idx" ON "tenants"("roomId");

-- CreateIndex
CREATE INDEX "tenants_name_email_idx" ON "tenants"("name", "email");

-- CreateIndex
CREATE UNIQUE INDEX "total_units_billId_key" ON "total_units"("billId");

-- CreateIndex
CREATE INDEX "total_units_billId_idx" ON "total_units"("billId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_tenantId_key" ON "users"("tenantId");

-- CreateIndex
CREATE INDEX "users_email_idx" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_role_isActive_idx" ON "users"("role", "isActive");

-- CreateIndex
CREATE INDEX "users_tenantId_idx" ON "users"("tenantId");

-- AddForeignKey
ALTER TABLE "bills" ADD CONSTRAINT "bills_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_contractTypeId_fkey" FOREIGN KEY ("contractTypeId") REFERENCES "contract_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_services" ADD CONSTRAINT "customer_services_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_billId_fkey" FOREIGN KEY ("billId") REFERENCES "bills"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "occupants" ADD CONSTRAINT "occupants_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receipts" ADD CONSTRAINT "receipts_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tenants" ADD CONSTRAINT "tenants_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "total_units" ADD CONSTRAINT "total_units_billId_fkey" FOREIGN KEY ("billId") REFERENCES "bills"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;
