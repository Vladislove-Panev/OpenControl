using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Leader02.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("Npgsql:PostgresExtension:fuzzystrmatch", ",,");

            migrationBuilder.CreateTable(
                name: "AdminUsers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    UserName = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: true),
                    Password = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AdminUsers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Departments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Abbreviation = table.Column<string>(type: "text", nullable: false),
                    DepartmentUrl = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Departments", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "OpenControlServices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Number = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false),
                    OpenControlServiceUrl = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OpenControlServices", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    FirstName = table.Column<string>(type: "text", nullable: false),
                    LastName = table.Column<string>(type: "text", nullable: false),
                    MiddleName = table.Column<string>(type: "text", nullable: true),
                    MobilePhone = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: false),
                    UserType = table.Column<int>(type: "integer", nullable: false),
                    Inn = table.Column<int>(type: "integer", nullable: true),
                    Snils = table.Column<int>(type: "integer", nullable: true),
                    Kpp = table.Column<int>(type: "integer", nullable: true),
                    Okveds = table.Column<int>(type: "integer", nullable: true),
                    DitSecurityQuestion = table.Column<string>(type: "text", nullable: true),
                    DitSecurityAnswer = table.Column<string>(type: "text", nullable: true),
                    Password = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SubDepartments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    SubDepartmentUrl = table.Column<string>(type: "text", nullable: true),
                    SubDepartmentDescription = table.Column<string>(type: "text", nullable: true),
                    DepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SubDepartments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SubDepartments_Departments_DepartmentId",
                        column: x => x.DepartmentId,
                        principalTable: "Departments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ChatBotRequests",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Created = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    FeedBack = table.Column<int>(type: "integer", nullable: true),
                    FeedBackString = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<long>(type: "bigint", nullable: true),
                    DepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChatBotRequests", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ChatBotRequests_Departments_DepartmentId",
                        column: x => x.DepartmentId,
                        principalTable: "Departments",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ChatBotRequests_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ConsultationSlots",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SlotDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    SlotTime = table.Column<string>(type: "text", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    OtherInformation = table.Column<string>(type: "text", nullable: true),
                    SubDepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ConsultationSlots", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ConsultationSlots_SubDepartments_SubDepartmentId",
                        column: x => x.SubDepartmentId,
                        principalTable: "SubDepartments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ConsultationTopics",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Topic = table.Column<string>(type: "text", nullable: false),
                    SubDepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ConsultationTopics", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ConsultationTopics_SubDepartments_SubDepartmentId",
                        column: x => x.SubDepartmentId,
                        principalTable: "SubDepartments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "DepartmentUsers",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    LastName = table.Column<string>(type: "text", nullable: false),
                    FirstName = table.Column<string>(type: "text", nullable: false),
                    MiddleName = table.Column<string>(type: "text", nullable: true),
                    Email = table.Column<string>(type: "text", nullable: false),
                    MobilePhone = table.Column<string>(type: "text", nullable: true),
                    StationaryPhone = table.Column<string>(type: "text", nullable: true),
                    Password = table.Column<string>(type: "text", nullable: false),
                    SubDepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DepartmentUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DepartmentUsers_SubDepartments_SubDepartmentId",
                        column: x => x.SubDepartmentId,
                        principalTable: "SubDepartments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "LegalActs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    LegalActType = table.Column<string>(type: "text", nullable: false),
                    DocumentDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    PublishDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    LegalActUrl = table.Column<string>(type: "text", nullable: true),
                    DepartmentId = table.Column<int>(type: "integer", nullable: true),
                    SubDepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LegalActs", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LegalActs_Departments_DepartmentId",
                        column: x => x.DepartmentId,
                        principalTable: "Departments",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_LegalActs_SubDepartments_SubDepartmentId",
                        column: x => x.SubDepartmentId,
                        principalTable: "SubDepartments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Requirements",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Number = table.Column<int>(type: "integer", nullable: false),
                    BasicRequirementDescription = table.Column<string>(type: "text", nullable: true),
                    BasicRequirementDetail = table.Column<string>(type: "text", nullable: true),
                    RequirementType = table.Column<int>(type: "integer", nullable: true),
                    RequirementNpasJson = table.Column<string>(type: "text", nullable: false),
                    RequirementVerificationMethodsJson = table.Column<string>(type: "text", nullable: false),
                    RequirementResponsibilitiesJson = table.Column<string>(type: "text", nullable: false),
                    RequirementProfilingJson = table.Column<string>(type: "text", nullable: false),
                    DepartmentId = table.Column<int>(type: "integer", nullable: true),
                    SubDepartmentId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Requirements", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Requirements_Departments_DepartmentId",
                        column: x => x.DepartmentId,
                        principalTable: "Departments",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Requirements_SubDepartments_SubDepartmentId",
                        column: x => x.SubDepartmentId,
                        principalTable: "SubDepartments",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "SubDepartmentTsVectors",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SubDepartmentTsVectors", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SubDepartmentTsVectors_SubDepartments_Id",
                        column: x => x.Id,
                        principalTable: "SubDepartments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ChatBotRequestsMessages",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Message = table.Column<string>(type: "text", nullable: false),
                    State = table.Column<int>(type: "integer", nullable: false),
                    ChatBotRequestId = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ChatBotRequestsMessages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ChatBotRequestsMessages_ChatBotRequests_ChatBotRequestId",
                        column: x => x.ChatBotRequestId,
                        principalTable: "ChatBotRequests",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Consultations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Topic = table.Column<string>(type: "text", nullable: true),
                    StarDateTime = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    FinishDateTime = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    VideoRecordPath = table.Column<string>(type: "text", nullable: true),
                    OtherInformation = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<long>(type: "bigint", nullable: true),
                    DepartmentUserId = table.Column<long>(type: "bigint", nullable: true),
                    ConsultationSlotId = table.Column<int>(type: "integer", nullable: true),
                    ConsultationSlotId1 = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Consultations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Consultations_ConsultationSlots_ConsultationSlotId1",
                        column: x => x.ConsultationSlotId1,
                        principalTable: "ConsultationSlots",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Consultations_DepartmentUsers_DepartmentUserId",
                        column: x => x.DepartmentUserId,
                        principalTable: "DepartmentUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Consultations_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "LegalActTsVectors",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LegalActTsVectors", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LegalActTsVectors_LegalActs_Id",
                        column: x => x.Id,
                        principalTable: "LegalActs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RequirementTsVectors",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false),
                    Number = table.Column<int>(type: "integer", nullable: true),
                    BasicRequirement = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RequirementTsVectors", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RequirementTsVectors_Requirements_Id",
                        column: x => x.Id,
                        principalTable: "Requirements",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ChatBotRequests_DepartmentId",
                table: "ChatBotRequests",
                column: "DepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ChatBotRequests_UserId",
                table: "ChatBotRequests",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_ChatBotRequestsMessages_ChatBotRequestId",
                table: "ChatBotRequestsMessages",
                column: "ChatBotRequestId");

            migrationBuilder.CreateIndex(
                name: "IX_Consultations_ConsultationSlotId1",
                table: "Consultations",
                column: "ConsultationSlotId1");

            migrationBuilder.CreateIndex(
                name: "IX_Consultations_DepartmentUserId",
                table: "Consultations",
                column: "DepartmentUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Consultations_UserId",
                table: "Consultations",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_ConsultationSlots_SubDepartmentId",
                table: "ConsultationSlots",
                column: "SubDepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_ConsultationTopics_SubDepartmentId",
                table: "ConsultationTopics",
                column: "SubDepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_DepartmentUsers_SubDepartmentId",
                table: "DepartmentUsers",
                column: "SubDepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_LegalActs_DepartmentId",
                table: "LegalActs",
                column: "DepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_LegalActs_SubDepartmentId",
                table: "LegalActs",
                column: "SubDepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Requirements_DepartmentId",
                table: "Requirements",
                column: "DepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Requirements_SubDepartmentId",
                table: "Requirements",
                column: "SubDepartmentId");

            migrationBuilder.CreateIndex(
                name: "IX_SubDepartments_DepartmentId",
                table: "SubDepartments",
                column: "DepartmentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AdminUsers");

            migrationBuilder.DropTable(
                name: "ChatBotRequestsMessages");

            migrationBuilder.DropTable(
                name: "Consultations");

            migrationBuilder.DropTable(
                name: "ConsultationTopics");

            migrationBuilder.DropTable(
                name: "LegalActTsVectors");

            migrationBuilder.DropTable(
                name: "OpenControlServices");

            migrationBuilder.DropTable(
                name: "RequirementTsVectors");

            migrationBuilder.DropTable(
                name: "SubDepartmentTsVectors");

            migrationBuilder.DropTable(
                name: "ChatBotRequests");

            migrationBuilder.DropTable(
                name: "ConsultationSlots");

            migrationBuilder.DropTable(
                name: "DepartmentUsers");

            migrationBuilder.DropTable(
                name: "LegalActs");

            migrationBuilder.DropTable(
                name: "Requirements");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "SubDepartments");

            migrationBuilder.DropTable(
                name: "Departments");
        }
    }
}
