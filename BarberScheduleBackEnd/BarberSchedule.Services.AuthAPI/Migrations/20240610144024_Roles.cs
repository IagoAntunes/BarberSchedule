using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace BarberSchedule.Services.AuthAPI.Migrations
{
    /// <inheritdoc />
    public partial class Roles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "8e6219e5-c54c-4c3d-a58b-ccf0001d6636", "8e6219e5-c54c-4c3d-a58b-ccf0001d6636", "CLIENT", "CLIENT" },
                    { "ea43887c-e3d9-47bf-b8cd-72f01cb65146", "ea43887c-e3d9-47bf-b8cd-72f01cb65146", "BARBERSHOP", "BARBERSHOP" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "8e6219e5-c54c-4c3d-a58b-ccf0001d6636");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ea43887c-e3d9-47bf-b8cd-72f01cb65146");
        }
    }
}
