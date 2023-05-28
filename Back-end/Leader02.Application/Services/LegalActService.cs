using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class LegalActService : ILegalActService
{
    private readonly ILegalActTsVectorRepository _legalActTsVectorRepository;
    private readonly ILegalActRepository _legalActRepository;

    public LegalActService(IServiceScopeFactory serviceScopeFactory)
    {
        _legalActTsVectorRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<ILegalActTsVectorRepository>();
        _legalActRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<ILegalActRepository>();
    }

    
    public Task<List<LegalActDto>> FindBySubDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<LegalActDto>> FindByDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public async Task<LegalActDto?> FindByName(string name, CancellationToken ct)
    {
        var legalActTsVectors = await _legalActTsVectorRepository.FindManyByName(name, ct);

        if (legalActTsVectors.Count > 0)
        {
            var legalAct = await _legalActRepository.GetById(legalActTsVectors[0].Id, ct);
            if (legalAct != null) return legalAct.LegalActToLegalActDto();
        }

        return null;
    }
 }