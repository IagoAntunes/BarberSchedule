using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BarberSchedule.Services.BarberShop.Migrations
{
    /// <inheritdoc />
    public partial class PaymentMethods : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "Price",
                table: "BarberShopInfo",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.CreateTable(
                name: "PaymentMethods",
                columns: table => new
                {
                    IdPaymentMethod = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaymentMethods", x => x.IdPaymentMethod);
                });

            migrationBuilder.CreateTable(
                name: "BarberShopPaymentMethods",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BarberShopId = table.Column<int>(type: "int", nullable: false),
                    PaymentMethodId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BarberShopPaymentMethods", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BarberShopPaymentMethods_BarberShopInfo_BarberShopId",
                        column: x => x.BarberShopId,
                        principalTable: "BarberShopInfo",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_BarberShopPaymentMethods_PaymentMethods_PaymentMethodId",
                        column: x => x.PaymentMethodId,
                        principalTable: "PaymentMethods",
                        principalColumn: "IdPaymentMethod",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BarberShopPaymentMethods_BarberShopId",
                table: "BarberShopPaymentMethods",
                column: "BarberShopId");

            migrationBuilder.CreateIndex(
                name: "IX_BarberShopPaymentMethods_PaymentMethodId",
                table: "BarberShopPaymentMethods",
                column: "PaymentMethodId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BarberShopPaymentMethods");

            migrationBuilder.DropTable(
                name: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Price",
                table: "BarberShopInfo");
        }
    }
}
