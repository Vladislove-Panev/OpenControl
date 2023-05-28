using System.Threading;
using System.Threading.Tasks;
using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Schema;
using Microsoft.Extensions.Logging;

namespace Leader02.ChatBotApi.Dialogs;

public class ConsultationDialog : CancelAndHelpDialog
{
    private readonly ILogger _logger;

    public ConsultationDialog(ILogger<ConsultationDialog> logger)
        : base(nameof(ConsultationDialog))
    {
        _logger = logger;

        AddDialog(new TextPrompt(nameof(TextPrompt)));

        var waterfallSteps = new WaterfallStep[]
        {
            FirstStepAsync
        };

        AddDialog(new WaterfallDialog(nameof(WaterfallDialog), waterfallSteps));

        // The initial child Dialog to run.
        InitialDialogId = nameof(WaterfallDialog);
    }

    private async Task<DialogTurnResult> FirstStepAsync(WaterfallStepContext stepContext, CancellationToken cancellationToken)
    {
        await stepContext.Context.SendActivityAsync(
            MessageFactory.Text("{ссылка на консультирование}", inputHint: InputHints.IgnoringInput), cancellationToken);

        return await stepContext.EndDialogAsync("", cancellationToken);
    }
}