using Leader.Domain.Entity;
using Leader.Domain.Enums;
using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace Leader02.Application.Services;

public class ConsultationService : IConsultationService
{
    private readonly IUserRepository _userRepository;
    private readonly IConsultationRepository _consultationRepository;
    private readonly IConsultationSlotRepository _consultationSlotRepository;

    public ConsultationService(IServiceScopeFactory serviceScopeFactory)
    {
        _consultationSlotRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IConsultationSlotRepository>();
        _userRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IUserRepository>();
        _consultationRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IConsultationRepository>();
    }

    public async Task<ConsultationDto?> CreateConsultation(string? topic, long userId, Guid consultationSlotId, CancellationToken ct)
    {
        var user = await _userRepository.GetById(userId, ct);
        if (user == null)
            return null;

        if (user.Consultations.IsNullOrEmpty())
        {
            user.Consultations = new List<Consultation>
            {
                new()
                {
                    Topic = topic, User = user, ConsultationSlotId = consultationSlotId
                }
            };
        }
        else
        {
            user.Consultations?.Add(
                new Consultation
                {
                    Topic = topic, User = user, ConsultationSlotId = consultationSlotId
                }
            );
        }

        //var consultation = 

        //var isSaved = await _consultationRepository.AddAsync(consultation, ct);
        var isSaved = await _userRepository.UpdateAsync(user, ct);

            var savedConsultation = await _consultationRepository.GetByConsultationSlotId(consultationSlotId, ct);
            var slot = await _consultationSlotRepository.GetById(consultationSlotId, ct);
            if (slot != null)
            {
                slot.Status = ConsultationSlotStatus.Busy;
                await _consultationSlotRepository.UpdateAsync(slot, ct);
            }

            return savedConsultation?.ConsultationToConsultationDto();
        

    }
}