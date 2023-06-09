﻿// <auto-generated />
using System;
using Leader02.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Leader02.Infrastructure.Migrations
{
    [DbContext(typeof(Leader02Context))]
    partial class Leader02ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.HasPostgresExtension(modelBuilder, "fuzzystrmatch");
            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Leader.Domain.Entity.AdminUser", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .HasColumnType("text");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("UserName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("AdminUsers");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ChatBotRequest", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("Created")
                        .HasColumnType("timestamp without time zone");

                    b.Property<int?>("DepartmentId")
                        .HasColumnType("integer");

                    b.Property<int?>("FeedBack")
                        .HasColumnType("integer");

                    b.Property<string>("FeedBackString")
                        .HasColumnType("text");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.HasKey("Id");

                    b.HasIndex("DepartmentId");

                    b.HasIndex("UserId");

                    b.ToTable("ChatBotRequests");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ChatBotRequestMessage", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid?>("ChatBotRequestId")
                        .HasColumnType("uuid");

                    b.Property<string>("Message")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("State")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("ChatBotRequestId");

                    b.ToTable("ChatBotRequestsMessages");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Consultation", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int?>("ConsultationSlotId")
                        .HasColumnType("integer");

                    b.Property<Guid?>("ConsultationSlotId1")
                        .HasColumnType("uuid");

                    b.Property<long?>("DepartmentUserId")
                        .HasColumnType("bigint");

                    b.Property<DateTime?>("FinishDateTime")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("OtherInformation")
                        .HasColumnType("text");

                    b.Property<DateTime?>("StarDateTime")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("Topic")
                        .HasColumnType("text");

                    b.Property<long?>("UserId")
                        .HasColumnType("bigint");

                    b.Property<string>("VideoRecordPath")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("ConsultationSlotId1");

                    b.HasIndex("DepartmentUserId");

                    b.HasIndex("UserId");

                    b.ToTable("Consultations");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ConsultationSlot", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("OtherInformation")
                        .HasColumnType("text");

                    b.Property<DateTime>("SlotDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("SlotTime")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Status")
                        .HasColumnType("integer");

                    b.Property<int?>("SubDepartmentId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("SubDepartmentId");

                    b.ToTable("ConsultationSlots");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ConsultationTopic", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("SubDepartmentId")
                        .HasColumnType("integer");

                    b.Property<string>("Topic")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("SubDepartmentId");

                    b.ToTable("ConsultationTopics");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Department", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Abbreviation")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("DepartmentUrl")
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Departments");
                });

            modelBuilder.Entity("Leader.Domain.Entity.DepartmentUser", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("MiddleName")
                        .HasColumnType("text");

                    b.Property<string>("MobilePhone")
                        .HasColumnType("text");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("StationaryPhone")
                        .HasColumnType("text");

                    b.Property<int?>("SubDepartmentId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("SubDepartmentId");

                    b.ToTable("DepartmentUsers");
                });

            modelBuilder.Entity("Leader.Domain.Entity.LegalAct", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("DepartmentId")
                        .HasColumnType("integer");

                    b.Property<DateTime>("DocumentDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("LegalActType")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LegalActUrl")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("PublishDate")
                        .HasColumnType("timestamp without time zone");

                    b.Property<int?>("SubDepartmentId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("DepartmentId");

                    b.HasIndex("SubDepartmentId");

                    b.ToTable("LegalActs");
                });

            modelBuilder.Entity("Leader.Domain.Entity.LegalActTsVector", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("integer");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("LegalActTsVectors");
                });

            modelBuilder.Entity("Leader.Domain.Entity.OpenControlService", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Number")
                        .HasColumnType("integer");

                    b.Property<string>("OpenControlServiceUrl")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("OpenControlServices");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Requirement", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<string>("BasicRequirementDescription")
                        .HasColumnType("text");

                    b.Property<string>("BasicRequirementDetail")
                        .HasColumnType("text");

                    b.Property<int?>("DepartmentId")
                        .HasColumnType("integer");

                    b.Property<int>("Number")
                        .HasColumnType("integer");

                    b.Property<string>("RequirementNpasJson")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("RequirementProfilingJson")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("RequirementResponsibilitiesJson")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("RequirementType")
                        .HasColumnType("integer");

                    b.Property<string>("RequirementVerificationMethodsJson")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("SubDepartmentId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("DepartmentId");

                    b.HasIndex("SubDepartmentId");

                    b.ToTable("Requirements");
                });

            modelBuilder.Entity("Leader.Domain.Entity.RequirementTsVector", b =>
                {
                    b.Property<long>("Id")
                        .HasColumnType("bigint");

                    b.Property<string>("BasicRequirement")
                        .HasColumnType("text");

                    b.Property<int?>("Number")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.ToTable("RequirementTsVectors");
                });

            modelBuilder.Entity("Leader.Domain.Entity.SubDepartment", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("DepartmentId")
                        .HasColumnType("integer");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("SubDepartmentDescription")
                        .HasColumnType("text");

                    b.Property<string>("SubDepartmentUrl")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("DepartmentId");

                    b.ToTable("SubDepartments");
                });

            modelBuilder.Entity("Leader.Domain.Entity.SubDepartmentTsVector", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("integer");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("SubDepartmentTsVectors");
                });

            modelBuilder.Entity("Leader.Domain.Entity.User", b =>
                {
                    b.Property<long>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bigint");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<long>("Id"));

                    b.Property<string>("DitSecurityAnswer")
                        .HasColumnType("text");

                    b.Property<string>("DitSecurityQuestion")
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("Inn")
                        .HasColumnType("integer");

                    b.Property<int?>("Kpp")
                        .HasColumnType("integer");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("MiddleName")
                        .HasColumnType("text");

                    b.Property<string>("MobilePhone")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("Okveds")
                        .HasColumnType("integer");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("Snils")
                        .HasColumnType("integer");

                    b.Property<int>("UserType")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ChatBotRequest", b =>
                {
                    b.HasOne("Leader.Domain.Entity.Department", "Department")
                        .WithMany("ChatBotRequests")
                        .HasForeignKey("DepartmentId");

                    b.HasOne("Leader.Domain.Entity.User", "User")
                        .WithMany("ChatBotRequests")
                        .HasForeignKey("UserId");

                    b.Navigation("Department");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ChatBotRequestMessage", b =>
                {
                    b.HasOne("Leader.Domain.Entity.ChatBotRequest", "ChatBotRequest")
                        .WithMany("ChatBotRequestMessages")
                        .HasForeignKey("ChatBotRequestId");

                    b.Navigation("ChatBotRequest");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Consultation", b =>
                {
                    b.HasOne("Leader.Domain.Entity.ConsultationSlot", "ConsultationSlot")
                        .WithMany()
                        .HasForeignKey("ConsultationSlotId1");

                    b.HasOne("Leader.Domain.Entity.DepartmentUser", "DepartmentUser")
                        .WithMany("Consultations")
                        .HasForeignKey("DepartmentUserId");

                    b.HasOne("Leader.Domain.Entity.User", "User")
                        .WithMany("Consultations")
                        .HasForeignKey("UserId");

                    b.Navigation("ConsultationSlot");

                    b.Navigation("DepartmentUser");

                    b.Navigation("User");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ConsultationSlot", b =>
                {
                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithMany("ConsultationSlots")
                        .HasForeignKey("SubDepartmentId");

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ConsultationTopic", b =>
                {
                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithMany("ConsultationTopics")
                        .HasForeignKey("SubDepartmentId");

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.DepartmentUser", b =>
                {
                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithMany("DepartmentUsers")
                        .HasForeignKey("SubDepartmentId");

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.LegalAct", b =>
                {
                    b.HasOne("Leader.Domain.Entity.Department", "Department")
                        .WithMany("LegalActs")
                        .HasForeignKey("DepartmentId");

                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithMany("LegalActs")
                        .HasForeignKey("SubDepartmentId");

                    b.Navigation("Department");

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.LegalActTsVector", b =>
                {
                    b.HasOne("Leader.Domain.Entity.LegalAct", "LegalAct")
                        .WithOne("LegalActTsVectorName")
                        .HasForeignKey("Leader.Domain.Entity.LegalActTsVector", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("LegalAct");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Requirement", b =>
                {
                    b.HasOne("Leader.Domain.Entity.Department", "Department")
                        .WithMany("Requirements")
                        .HasForeignKey("DepartmentId");

                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithMany("Requirements")
                        .HasForeignKey("SubDepartmentId");

                    b.Navigation("Department");

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.RequirementTsVector", b =>
                {
                    b.HasOne("Leader.Domain.Entity.Requirement", "Requirement")
                        .WithOne("RequirementBasicRequirement")
                        .HasForeignKey("Leader.Domain.Entity.RequirementTsVector", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Requirement");
                });

            modelBuilder.Entity("Leader.Domain.Entity.SubDepartment", b =>
                {
                    b.HasOne("Leader.Domain.Entity.Department", "Department")
                        .WithMany("SubDepartments")
                        .HasForeignKey("DepartmentId");

                    b.Navigation("Department");
                });

            modelBuilder.Entity("Leader.Domain.Entity.SubDepartmentTsVector", b =>
                {
                    b.HasOne("Leader.Domain.Entity.SubDepartment", "SubDepartment")
                        .WithOne("SubDepartmentTsVector")
                        .HasForeignKey("Leader.Domain.Entity.SubDepartmentTsVector", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("SubDepartment");
                });

            modelBuilder.Entity("Leader.Domain.Entity.ChatBotRequest", b =>
                {
                    b.Navigation("ChatBotRequestMessages");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Department", b =>
                {
                    b.Navigation("ChatBotRequests");

                    b.Navigation("LegalActs");

                    b.Navigation("Requirements");

                    b.Navigation("SubDepartments");
                });

            modelBuilder.Entity("Leader.Domain.Entity.DepartmentUser", b =>
                {
                    b.Navigation("Consultations");
                });

            modelBuilder.Entity("Leader.Domain.Entity.LegalAct", b =>
                {
                    b.Navigation("LegalActTsVectorName");
                });

            modelBuilder.Entity("Leader.Domain.Entity.Requirement", b =>
                {
                    b.Navigation("RequirementBasicRequirement");
                });

            modelBuilder.Entity("Leader.Domain.Entity.SubDepartment", b =>
                {
                    b.Navigation("ConsultationSlots");

                    b.Navigation("ConsultationTopics");

                    b.Navigation("DepartmentUsers");

                    b.Navigation("LegalActs");

                    b.Navigation("Requirements");

                    b.Navigation("SubDepartmentTsVector");
                });

            modelBuilder.Entity("Leader.Domain.Entity.User", b =>
                {
                    b.Navigation("ChatBotRequests");

                    b.Navigation("Consultations");
                });
#pragma warning restore 612, 618
        }
    }
}
