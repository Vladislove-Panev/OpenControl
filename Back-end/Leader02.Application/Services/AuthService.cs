using System.Security.Cryptography;
using System.Text;
using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Jwt;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class AuthService : IAuthService
{
    private readonly IJwtUtils _jwtUtils;
    private readonly IUserRepository _userRepository;
    private readonly IDepartmentUserRepository _departmentUserRepository;
    private const string SecurityKey = "ComplexKeyHere_12121";

    public AuthService(IServiceScopeFactory serviceScopeFactory, IJwtUtils jwtUtils)
    {
        _userRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IUserRepository>();
        _departmentUserRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IDepartmentUserRepository>();
        _jwtUtils = jwtUtils;
    }

    public async Task<AuthenticationUserDto?> Authenticate(string email, string password, int userType, CancellationToken ct)
    {
        if (userType == 0)
        {
            var user = await _userRepository.GetByEmailAndPassword(email, Encrypt(password), ct);
            if (user == null)
                return new AuthenticationUserDto
                {
                    IsAuthenticated = false,
                    Message = $"No Accounts Registered with {email}."
                };
            
            var userToken = _jwtUtils.GenerateUserJwtToken(user);

            return new AuthenticationUserDto
            {
                Email = user.Email,
                Role = "User",
                Token = userToken,
                IsAuthenticated = true,
                Message = "Get token"
            };
        }

        var departmentUser = await _departmentUserRepository.GetByEmailAndPassword(email, Encrypt(password), ct);
        if (departmentUser == null)
            return new AuthenticationUserDto
            {
                IsAuthenticated = false,
                Message = $"No Accounts Registered with {email}."
            };
            
        var departmentUserToken = _jwtUtils.GenerateDepartmentUserJwtToken(departmentUser);

        return new AuthenticationUserDto
        {
            Email = departmentUser.Email,
            Role = "DepartmentUser",
            Token = departmentUserToken,
            IsAuthenticated = true,
            Message = "Get token"
        };
    }

    public async Task<UserDto?> Register(string firstName, string lastName, string? middleName, string email, string mobilePhone, string password, 
        string repeatPassword, string? ditSecurityQuestion, string? ditSecurityAnswer, CancellationToken ct)
    {
        if (password != repeatPassword)
            return null;
        
        var checkUser = await _userRepository.GetByEmail(email, ct);
        if (checkUser != null)
            return null;

        var newUser = new User
        {
            Email = email, 
            FirstName = firstName, 
            LastName = lastName, 
            MiddleName = middleName, 
            Password = Encrypt(password), 
            MobilePhone = mobilePhone, 
            DitSecurityQuestion = ditSecurityQuestion, 
            DitSecurityAnswer = ditSecurityAnswer,
        };
        
        var isSaved = await _userRepository.AddAsync(newUser, ct);

        if (isSaved)
        {
            var user = await _userRepository.GetByEmail(email, ct);
            return user?.UserToUserDto();
        }

        return null;
    }


        //This method is used to convert the plain text to Encrypted/Un-Readable Text format.
        private string Encrypt(string PlainText)
        {
            // Getting the bytes of Input String.
            byte[] toEncryptedArray = UTF8Encoding.UTF8.GetBytes(PlainText);

            MD5CryptoServiceProvider objMD5CryptoService = new MD5CryptoServiceProvider();
            //Gettting the bytes from the Security Key and Passing it to compute the Corresponding Hash Value.
            byte[] securityKeyArray = objMD5CryptoService.ComputeHash(UTF8Encoding.UTF8.GetBytes(SecurityKey));
            //De-allocatinng the memory after doing the Job.
            objMD5CryptoService.Clear();

            var objTripleDESCryptoService = new TripleDESCryptoServiceProvider();
            //Assigning the Security key to the TripleDES Service Provider.
            objTripleDESCryptoService.Key = securityKeyArray;
            //Mode of the Crypto service is Electronic Code Book.
            objTripleDESCryptoService.Mode = CipherMode.ECB;
            //Padding Mode is PKCS7 if there is any extra byte is added.
            objTripleDESCryptoService.Padding = PaddingMode.PKCS7;


            var objCrytpoTransform = objTripleDESCryptoService.CreateEncryptor();
            //Transform the bytes array to resultArray
            byte[] resultArray = objCrytpoTransform.TransformFinalBlock(toEncryptedArray, 0, toEncryptedArray.Length);
            objTripleDESCryptoService.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        //This method is used to convert the Encrypted/Un-Readable Text back to readable  format.
        public static string Decrypt(string CipherText)
        {
            byte[] toEncryptArray = Convert.FromBase64String(CipherText);
            MD5CryptoServiceProvider objMD5CryptoService = new MD5CryptoServiceProvider();

            //Gettting the bytes from the Security Key and Passing it to compute the Corresponding Hash Value.
            byte[] securityKeyArray = objMD5CryptoService.ComputeHash(UTF8Encoding.UTF8.GetBytes(SecurityKey));
            objMD5CryptoService.Clear();

            var objTripleDESCryptoService = new TripleDESCryptoServiceProvider();
            //Assigning the Security key to the TripleDES Service Provider.
            objTripleDESCryptoService.Key = securityKeyArray;
            //Mode of the Crypto service is Electronic Code Book.
            objTripleDESCryptoService.Mode = CipherMode.ECB;
            //Padding Mode is PKCS7 if there is any extra byte is added.
            objTripleDESCryptoService.Padding = PaddingMode.PKCS7;

            var objCrytpoTransform = objTripleDESCryptoService.CreateDecryptor();
            //Transform the bytes array to resultArray
            byte[] resultArray = objCrytpoTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            objTripleDESCryptoService.Clear();

            //Convert and return the decrypted data/byte into string format.
            return UTF8Encoding.UTF8.GetString(resultArray);
        }
}