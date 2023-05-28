using Leader.Domain.Enums;

namespace Leader.Domain.Entity;

public class User
{
    public long Id { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? MiddleName { get; set; } = string.Empty;
    public string MobilePhone { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public int? Inn { get; set; }
    public int? Snils { get; set; }
    public int? Kpp { get; set; }
    public int? Okveds { get; set; } //хранить строкой в json все коды оквэд
    public string? DitSecurityQuestion { get; set; }
    public string? DitSecurityAnswer { get; set; }
    public string Password { get; set; } = string.Empty;

    public List<ChatBotRequest>? ChatBotRequests { get; set; }
    public List<Consultation>? Consultations { get; set; }

    //public DateTime LastVisitDateTime { get; set; }
    //public DateTime CreatedDateTime { get; set; }
    //public string Address { get; set; } = string.Empty;
}