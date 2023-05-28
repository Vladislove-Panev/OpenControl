using Leader02.Application.DtoModels;

namespace Leader02.Api.Models.Response.Consultation;

public class GetConsultationsResponse
{
    public List<ConsultationDto> Consultations { get; set; } = new();
}