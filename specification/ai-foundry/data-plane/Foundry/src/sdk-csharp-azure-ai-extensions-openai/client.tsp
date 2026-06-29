import "../sdk-common/error.default.tsp";
import "../common/servicepatterns.tsp";
import "../openai-conversations/routes.tsp";
import "../openai-responses/routes.tsp";
import "../toolboxes/models.tsp";
import "../agents/models.tsp";
import "../toolboxes/models.tsp";
import "../skills/models.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@clientNamespace("Azure.AI.Extensions.OpenAI")
namespace Azure.AI.Projects {
  // ------------------------------------------------------------------------------------------------
  // Operation scope customizations - don't generate OpenAI operations that we'll use the OpenAI client for
  // ------------------------------------------------------------------------------------------------
  @@scope(Responses.createResponse, "!csharp");
  @@scope(Responses.getResponse, "!csharp");
  @@scope(Responses.deleteResponse, "!csharp");
  @@scope(Responses.cancelResponse, "!csharp");
  @@scope(Responses.listInputItems, "!csharp");
  @@scope(Responses.listResponses, "!csharp");

  // These operations are temporarily preserved to root request/response models for
  // interim convenience layer support; to be removed once available in
  // https://github.com/openai/openai-dotnet
  @@scope(Conversations.createConversation, "!csharp");
  @@scope(Conversations.updateConversation, "!csharp");

  @@scope(Conversations.listConversations, "!csharp");
  @@scope(Conversations.getConversation, "!csharp");
  @@scope(Conversations.deleteConversation, "!csharp");
  @@scope(Conversations.createConversationItems, "!csharp");
  @@scope(Conversations.listConversationItems, "!csharp");
  @@scope(Conversations.getConversationItem, "!csharp");
  @@scope(Conversations.deleteConversationItem, "!csharp");

  // The ConversationResoruce is not yet emitted by the OpenAI SDK, so emitt it here for now. Once the OpenAI SDK emits it, this will be removed.
  @@clientNamespace(OpenAI.ConversationResource, "Azure.AI.Extensions.OpenAI", "csharp");
  @@usage(OpenAI.ConversationResource, Usage.output);
  @@access(OpenAI.ConversationResource, Access.public);
  @@clientName(OpenAI.ConversationResource, "ProjectConversation");

  @@usage(
    OpenAI.CreateConversationBody,
    Usage.output | Usage.json | Usage.input
  );
  @@access(OpenAI.CreateConversationBody, Access.public);
  @@usage(OpenAI.UpdateConversationBody, Usage.input);
  @@access(OpenAI.UpdateConversationBody, Access.public);

  @@clientNamespace(OpenAI.Metadata, "Azure.AI.Extensions.OpenAI", "csharp");
  @@access(OpenAI.Metadata, Access.internal);
  @@usage(OpenAI.Metadata, Usage.input | Usage.output);
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(OpenAI, "ProjectOpenAIClient");

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // Set it to default move all of OpenAI to "Internal" to make detecting new models 
  // simpler.
  // --------------------------------------------------------------------------------
  @@clientNamespace(OpenAI, "Azure.AI.Extensions.OpenAI.Internal", "csharp");
  @@clientNamespace(Azure.AI.Projects, "Azure.AI.Extensions.OpenAI", "csharp");

  @@clientName(CreatedBy, "AgentResponseItemSource");
  @@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

  @@clientName(
    OAuthConsentRequestOutputItem,
    "OAuthConsentRequestResponseItem"
  );
  
  @@clientName(WorkflowActionOutputItem.kind, "CSDLActionKind");

  // Now take the OpenAI models, and ensure that they are emitted as consumption points from the OpenAI SDK instead of re-emitting them here.
  // This is to ensure that the OpenAI SDK is the source of truth for these models, and we don't have duplicate definitions.
  @@usage(OpenAI.OutputItemType, Usage.output | Usage.json | Usage.input);
  @@alternateType(OpenAI.OutputItemType, {  identity: "OpenAI.Responses.ResponseItemKind",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.Tool, {  identity: "OpenAI.Responses.ResponseTool",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@usage(OpenAI.ToolType, Usage.output | Usage.json | Usage.input);
  @@alternateType(OpenAI.ToolType, {  identity: "OpenAI.Responses.ResponseToolKind",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ComputerTool, {  identity: "OpenAI.Responses.ComputerTool",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.WebSearchTool, {  identity: "OpenAI.Responses.WebSearchTool",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.FunctionTool, {  identity: "OpenAI.Responses.FunctionTool",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.AnnotationType, {  identity: "OpenAI.Responses.ResponseMessageAnnotationKind",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchCallOutputStatus, {  identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // --------------------------------------------------------------------------------
  // Export OpenAI types from the OpenAI package instead of re-emitting them.
  // Each target verified public in OpenAI 2.11.0. Input/output TypeSpec twins
  // (the "...Param" variants) are mapped onto the single OpenAI package type.
  // --------------------------------------------------------------------------------

  // ApplyPatch tool: status enums (closed enum -> extensible struct in package)
  @@alternateType(OpenAI.ApplyPatchCallOutputStatusParam, {  identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchCallStatus, {  identity: "OpenAI.Responses.ApplyPatchCallStatus",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchCallStatusParam, {  identity: "OpenAI.Responses.ApplyPatchCallStatus",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // ApplyPatch tool: file operations
  @@alternateType(OpenAI.ApplyPatchOperationParam, {  identity: "OpenAI.Responses.ApplyPatchOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchCreateFileOperation, {  identity: "OpenAI.Responses.ApplyPatchCreateFileOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchDeleteFileOperation, {  identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchDeleteFileOperationParam, {  identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchUpdateFileOperation, {  identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ApplyPatchUpdateFileOperationParam, {  identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Computer tool
  // @@alternateType(OpenAI.ComputerActionType, {  identity: "OpenAI.Responses.ComputerCallActionKind",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ComputerCallSafetyCheckParam, {  identity: "OpenAI.Responses.ComputerCallSafetyCheck",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Message item
  //@@alternateType(OpenAI.MessageRole, {  identity: "OpenAI.Responses.MessageRole",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  //@@alternateType(OpenAI.MessageStatus, {  identity: "OpenAI.Responses.MessageStatus",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Annotations
  @@alternateType(OpenAI.ContainerFileCitationBody, {  identity: "OpenAI.Responses.ContainerFileCitationMessageAnnotation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Response-level enums / details
  @@alternateType(OpenAI.ResponseErrorCode, {  identity: "OpenAI.Responses.ResponseErrorCode",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  // NOTE: the TypeSpec model is `union ServiceTier`; the emitter prefixes it to
  // ResponseServiceTier, so the alternateType source must be OpenAI.ServiceTier.
  @@alternateType(OpenAI.ServiceTier, {  identity: "OpenAI.Responses.ResponseServiceTier",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  
  // Token usage
  @@alternateType(OpenAI.ResponseUsage, {  identity: "OpenAI.Responses.ResponseTokenUsage",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ResponseUsageInputTokensDetails, {  identity: "OpenAI.Responses.ResponseInputTokenUsageDetails",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.ResponseUsageOutputTokensDetails, {  identity: "OpenAI.Responses.ResponseOutputTokenUsageDetails",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  @@alternateType(OpenAI.Annotation, {  identity: "OpenAI.Responses.ResponseMessageAnnotation",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  @@alternateType(OpenAI.Response, {  identity: "OpenAI.Responses.ResponseResult",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  
  // Now for some types, our TypeSpec is ahead of the OpenAI SDK, so we need to emit them here instead of mapping to the OpenAI SDK. These are all types that are not yet in the OpenAI SDK as of 2.11.0.
  @@clientNamespace(OpenAI.ContainerSkill, "Azure.AI.Extensions.OpenAI", "csharp");
  @@clientNamespace(OpenAI.ContainerSkillType, "Azure.AI.Extensions.OpenAI", "csharp");
  @@clientNamespace(OpenAI.CustomGrammarFormatParam, "Azure.AI.Extensions.OpenAI", "csharp");
  @@clientNamespace(OpenAI.LocalSkillParam, "Azure.AI.Extensions.OpenAI", "csharp");
  @@clientNamespace(OpenAI.ToolSearchExecutionType, "Azure.AI.Extensions.OpenAI", "csharp");

  // And now drop classes that aren't referenced, and aren't pruned.
  @@alternateType(OpenAI.InputTextContent, { identity: "System.Object" }, "csharp");
  @@alternateType(OpenAI.InputImageContent, { identity: "System.Object" }, "csharp");

  // --------------------------------------------------------------------------------
  // --------------------------------------------------------------------------------
  // LocalShellToolCallOutputStatus - named union to replace inline union
  // --------------------------------------------------------------------------------

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Matching OpenAI spec"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Matching OpenAI spec"
  union LocalShellToolCallOutputStatus {
    in_progress: "in_progress",
    completed: "completed",
    incomplete: "incomplete",
    null,
  }

  // Use alternateType to replace the inline union with our named union for SDK generation
  @@alternateType(
    OpenAI.LocalShellToolCallOutput.status,
    LocalShellToolCallOutputStatus
  );

  // Rename and include in typegraph
  @@clientName(
    LocalShellToolCallOutputStatus,
    "ItemLocalShellToolCallOutputStatus"
  );

  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------
  @@access(OpenAI.ItemLocalShellToolCall, Access.internal);
  @@clientName(OpenAI.ItemLocalShellToolCall, "InternalLocalShellToolCallItem");
  @@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemLocalShellToolCallOutput,
    "InternalLocalShellToolCallOutputItem"
  );

  @@access(OpenAI.ApplyPatchToolParam, Access.internal);
  @@clientName(OpenAI.ApplyPatchToolParam, "InternalApplyPatchToolParam");

  @@access(OpenAI.ApplyPatchToolCallItemParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchToolCallItemParam,
    "InternalApplyPatchToolCallItemParam"
  );

  @@access(OpenAI.ApplyPatchToolCall, Access.internal);
  @@clientName(OpenAI.ApplyPatchToolCall, "InternalApplyPatchToolCall");

  @@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCall,
    "InternalOutputItemApplyPatchToolCall"
  );

  @@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCall,
    "InternalOutputItemApplyPatchToolCall"
  );

  @@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCall,
    "InternalOutputItemApplyPatchToolCall"
  );

  @@access(OpenAI.OutputItemApplyPatchToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCallOutput,
    "InternalOutputItemApplyPatchToolCallOutput"
  );

  @@access(OpenAI.ApplyPatchFileOperation, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchFileOperation,
    "InternalApplyPatchFileOperation"
  );

  @@access(OpenAI.ApplyPatchCreateFileOperationParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchCreateFileOperationParam,
    "InternalApplyPatchCreateFileOperationParam"
  );

  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@clientName(OpenAI.OutputItemOutputMessage, "InternalOutputItemMessage");

  @@access(OpenAI.ItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.ItemComputerToolCall, "InternalItemComputerToolCall");

  @@access(OpenAI.FileSearchToolCall, Access.internal);
  @@clientName(OpenAI.FileSearchToolCall, "InternalFileSearchToolCall");

  @@access(OpenAI.OutputItemFileSearchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFileSearchToolCall,
    "InternalOutputItemFileSearchToolCall"
  );

  @@access(OpenAI.ItemMcpListTools, Access.internal);
  @@clientName(OpenAI.ItemMcpListTools, "InternalItemMcpListTools");

  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@clientName(
    OpenAI.OutputItemOutputMessage,
    "InternalOutputItemOutputMessage"
  );

  @@access(OpenAI.MessageContent, Access.internal);
  @@clientName(OpenAI.MessageContent, "InternalMessageContent");

  @@access(OpenAI.OutputMessageContent, Access.internal);
  @@clientName(OpenAI.OutputMessageContent, "InternalOutputMessageContent");

  @@access(OpenAI.OutputItemMcpListTools, Access.internal);
  @@clientName(OpenAI.OutputItemMcpListTools, "InternalOutputItemMcpListTools");

  @@access(OpenAI.OutputMessageContentOutputTextContent, Access.internal);
  @@clientName(
    OpenAI.OutputMessageContentOutputTextContent,
    "InternalOutputMessageContentOutputTextContent"
  );

  @@access(OpenAI.OutputContentOutputTextContent, Access.internal);
  @@clientName(
    OpenAI.OutputContentOutputTextContent,
    "InternalOutputContentOutputTextContent"
  );

  @@access(OpenAI.ItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.ItemComputerToolCall, "InternalItemComputerToolCall");
  @@access(OpenAI.OutputItemComputerToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemComputerToolCall,
    "InternalOutputItemComputerToolCall"
  );

  @@access(OpenAI.OutputItemCodeInterpreterToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemCodeInterpreterToolCall,
    "InternalOutputItemCodeInterpreterToolCall"
  );

  @@access(OpenAI.ItemOutputMessage, Access.internal);
  @@clientName(OpenAI.ItemOutputMessage, "InternalItemMessage");

  @@access(OpenAI.FunctionAndCustomToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.FunctionAndCustomToolCallOutput,
    "InternalFunctionAndCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemMcpToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemMcpToolCall, "InternalOutputItemMcpToolCall");

  @@access(OpenAI.ItemResourceMcpApprovalResponseResource, Access.internal);
  @@clientName(
    OpenAI.ItemResourceMcpApprovalResponseResource,
    "InternalOutputItemMcpApprovalResponseResource"
  );

  @@access(OpenAI.OutputItemMcpApprovalRequest, Access.internal);
  @@clientName(
    OpenAI.OutputItemMcpApprovalRequest,
    "InternalOutputItemMcpApprovalRequest"
  );

  @@access(OpenAI.OutputItemFunctionShellCallOutput, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionShellCallOutput,
    "InternalOutputItemFunctionShellCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionShellCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionShellCall,
    "InternalOutputItemFunctionShellCall"
  );

  @@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemLocalShellToolCallOutput,
    "InternalOutputItemLocalShellToolCallOutput"
  );

  @@access(OpenAI.OutputItemLocalShellToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemLocalShellToolCall,
    "InternalOutputItemLocalShellToolCall"
  );

  @@access(OpenAI.OutputItemImageGenToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemImageGenToolCall,
    "InternalOutputItemImageGenToolCall"
  );

  @@access(OpenAI.FunctionToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.FunctionToolCallOutput,
    "InternalOutputItemFunctionToolCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionToolCall,
    "InternalOutputItemFunctionToolCall"
  );

  @@access(OpenAI.OutputItemWebSearchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemWebSearchToolCall,
    "InternalOutputItemWebSearchToolCall"
  );

  @@access(OpenAI.ItemResourceComputerToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemResourceComputerToolCallOutput,
    "InternalOutputItemComputerToolCallOutput"
  );

  @@access(OpenAI.ItemCustomToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemCustomToolCallOutput,
    "InternalOutputItemCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemReasoningItem, Access.internal);
  @@clientName(
    OpenAI.OutputItemReasoningItem,
    "InternalOutputItemReasoningItem"
  );

  @@clientName(MemoryItem, "MemoryOutputItem");

  @@access(OpenAI.SummaryTextContent, Access.internal);
  @@clientName(OpenAI.SummaryTextContent, "InternalSummaryTextObject");

  @@access(OpenAI.OutputItemCompactionBody, Access.internal);
  @@clientName(
    OpenAI.OutputItemCompactionBody,
    "InternalOutputItemCompactionBody"
  );

  @@access(OpenAI.OutputItemCustomToolCallResource, Access.internal);
  @@clientName(
    OpenAI.OutputItemCustomToolCallResource,
    "InternalOutputItemCustomToolCallResource"
  );

  @@clientName(_AgentItemType.a2a_preview_call, "A2APreviewCall ");
  @@clientName(_AgentItemType.a2a_preview_call_output, "A2APreviewCallOutput");

  @@access(OpenAI.ComputerUsePreviewTool, Access.internal);
  @@clientName(OpenAI.ComputerUsePreviewTool, "InternalComputerUsePreviewTool");
  @@access(OpenAI.FileSearchTool, Access.internal);
  @@clientName(OpenAI.FileSearchTool, "InternalFileSearchTool");

  @@access(OpenAI.ToolChoiceParam, Access.internal);
  @@clientName(OpenAI.ToolChoiceParam, "InternalToolChoiceParam");

  // Emit Azure-specific OutputItem subtypes as public classes
  @@access(BingGroundingToolCall, Access.public);
  @@usage(BingGroundingToolCall, Usage.input);

  @@access(BingGroundingToolCallOutput, Access.public);
  @@usage(BingGroundingToolCallOutput, Usage.input);

  @@access(SharepointGroundingToolCall, Access.public);
  @@usage(SharepointGroundingToolCall, Usage.input);

  @@access(SharepointGroundingToolCallOutput, Access.public);
  @@usage(SharepointGroundingToolCallOutput, Usage.input);

  @@access(AzureAISearchToolCall, Access.public);
  @@usage(AzureAISearchToolCall, Usage.input);

  @@access(AzureAISearchToolCallOutput, Access.public);
  @@usage(AzureAISearchToolCallOutput, Usage.input);

  @@access(BingCustomSearchToolCall, Access.public);
  @@usage(BingCustomSearchToolCall, Usage.input);

  @@access(BingCustomSearchToolCallOutput, Access.public);
  @@usage(BingCustomSearchToolCallOutput, Usage.input);

  @@access(OpenApiToolCall, Access.public);
  @@usage(OpenApiToolCall, Usage.input);

  @@access(OpenApiToolCallOutput, Access.public);
  @@usage(OpenApiToolCallOutput, Usage.input);

  @@access(BrowserAutomationToolCall, Access.public);
  @@usage(BrowserAutomationToolCall, Usage.input);

  @@access(BrowserAutomationToolCallOutput, Access.public);
  @@usage(BrowserAutomationToolCallOutput, Usage.input);

  @@access(FabricDataAgentToolCall, Access.public);
  @@usage(FabricDataAgentToolCall, Usage.input);

  @@access(FabricDataAgentToolCallOutput, Access.public);
  @@usage(FabricDataAgentToolCallOutput, Usage.input);

  @@access(AzureFunctionToolCall, Access.public);
  @@usage(AzureFunctionToolCall, Usage.input);

  @@access(AzureFunctionToolCallOutput, Access.public);
  @@usage(AzureFunctionToolCallOutput, Usage.input);

  @@access(A2AToolCall, Access.public);
  @@usage(A2AToolCall, Usage.input);

  @@access(A2AToolCallOutput, Access.public);
  @@usage(A2AToolCallOutput, Usage.input);

  @@access(MemorySearchToolCall, Access.public);
  @@usage(MemorySearchToolCall, Usage.input);

  @@access(MemoryCommandToolCall, Access.public);
  @@usage(MemoryCommandToolCall, Usage.input);

  @@access(MemoryCommandToolCallOutput, Access.public);
  @@usage(MemoryCommandToolCallOutput, Usage.input);



  @@access(CreatedBy, Access.public);
  @@usage(CreatedBy, Usage.output);
  @@clientName(CreatedBy, "AgentItemSource");
  @@clientName(OpenAI.DetailEnum, "ImageDetailLevel");
  @@clientName(OpenAI.ComputerScreenshotImage.image_url, "ImageUri");
  @@clientName(OpenAI.AutoCodeInterpreterToolParam.type, "Kind");
  @@clientName(AzureAISearchTool.azure_ai_search, "AzureAISearch");
  @@clientName(AzureFunctionBinding.type, "Kind");
  @@clientName(BingGroundingSearchConfiguration.set_lang, "Language");
  @@clientName(OpenAI.CustomToolParam.defer_loading, "ShouldDeferLoading");
  @@clientName(OpenAI.FunctionToolParam.defer_loading, "ShouldDeferLoading");
  @@clientName(OpenAI.FunctionToolParam.strict, "IsStrict");
  @@clientName(OpenAI.FunctionCallOutputStatusEnum, "FunctionCallOutputStatus");
  @@clientName(OpenAI.MCPToolFilter.read_only, "IsReadOnly");
  @@clientName(MemorySearchPreviewTool.update_delay, "UpdateDelayInSeconds");
  @@clientName(OpenApiFunctionDefinition.spec, "Specification");
  @@clientName(OpenApiTool.openapi, "OpenApi");
  @@clientName(StructuredOutputDefinition.strict, "IsStrict");
  @@clientName(OpenAI.WebSearchApproximateLocation.type, "Kind");
  // --------------------------------------------------------------------------------
  // Usage / Public accessibility overrides
  // --------------------------------------------------------------------------------

  // @@changePropertyType(OpenAI.InputMessage.role, OpenAI.MessageRole);

  @@copyProperties(
    OpenAI.OutputItem,
    {
      id?: string,
    }
  );

  @@usage(OpenAI.CustomToolParam, Usage.input | Usage.output);
  @@access(OpenAI.CustomToolParam, Access.internal);

  @@usage(OpenAI.FunctionShellToolParamEnvironment, Usage.input | Usage.output);
  @@access(OpenAI.FunctionShellToolParamEnvironment, Access.internal);

  @@usage(OpenApiAuthDetails, Usage.input);

  @@usage(OpenAI.OutputItem, Usage.input | Usage.output);
  @@access(OpenAI.OutputItem, Access.public);
  @@alternateType(OpenAI.OutputItem, {  identity: "OpenAI.Responses.ResponseItem",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Memory Stores search/update operations are the only Foundry operations that define
  // OpenAI.InputItem as inputs, which otherwise pulls in the entire OpenAI input-item
  // hierarchy (InputItem -> InputItemComputerToolCall -> ComputerAction -> ClickParam, etc.).
  // Map it to the OpenAI .NET library's ResponseItem, consistent with OutputItem above.
  @@alternateType(OpenAI.InputItem, {  identity: "OpenAI.Responses.ResponseItem",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
  @@alternateType(OpenAI.InputItemType, {  identity: "OpenAI.Responses.ResponseItemKind",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");

  // Just disappear it.
  @@alternateType(OpenAI.EasyInputMessage, { identity: "System.Object" }, "csharp");

  @@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

  @@usage(AgentId, Usage.output);
  @@access(AgentId, Access.public);

  @@usage(AgentReference, Usage.input);
  @@access(AgentReference, Access.public);

  @@usage(ApiError, Usage.output);
  @@access(ApiError, Access.public);

  @@usage(StructuredOutputsOutputItem, Usage.input | Usage.output);

  // --------------------------------------------------------------------------------
  // Renames for tools.
  // --------------------------------------------------------------------------------
  @@clientName(
    OpenAI.FunctionCallOutputStatusEnum,
    "ResponsesFunctionCallOutputStatus"
  );
  @@clientName(OpenAI.FunctionCallStatus, "ResponsesFunctionCallStatus");
  //@@alternateType(OpenAI.ToolSearchExecutionType, {  identity: "OpenAI.ToolSearchExecutionType",  package: "OpenAI",  minVersion: "2.11.0"}, "csharp");
}
