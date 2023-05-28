using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class ConsultationTopicMapper
{
    public static partial ConsultationTopicDto ConsultationTopicToConsultationTopicDto(this ConsultationTopic consultationTopic);
    public static partial List<ConsultationTopicDto> ConsultationTopicsToConsultationTopicsDto(this List<ConsultationTopic> consultationTopics);
}