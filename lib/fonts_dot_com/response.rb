#module FontsDotCom
#  class Response
#
#  class ApiError < StandardError 
#    attr :response
#    
#    def initialize(response)
#      @response = response
#    end
#
#    def error_field
#      # TODO
#      #response.status[:errorField]
#    end
#  end
#
#  #class NonError < ApiError; end
#  #class ApiInMaintenance < ApiError; end
#  #class AccountNotFoundError < ApiError; end
#  #class ExceededMaximumRequests < ApiError; end
#  #class CannotConnectToAccountDatabase < ApiError; end
#  #class MissingApiVersionNumber < ApiError; end
#  #class UnknownFunctionName < ApiError; end
#  #class FunctionNotAvailableForThisAccount < ApiError; end
#  #class UnknownFormatRequested < ApiError; end
#  #class DatabaseInMaintenance < ApiError; end
#  #class AuthenticationParametersNotFound < ApiError; end
#  #class RequiredParametersAreMissing < ApiError; end
#  #class InvalidId < ApiError; end
#  #class ParameterMustHaveAUniqueValue < ApiError; end
#  #class InconsistentParameterSet < ApiError; end
#  #class IncorrectDataTypeOrFormat < ApiError; end
#  #class MalformedRequest < ApiError; end
#  #class InvalidValue < ApiError; end
#  #class DocumentNoLongerEditable < ApiError; end
#  #class ExceededMaxSubrequests < ApiError; end
#  #class CouponHasNotBeenIssued < ApiError; end
#  #class CouponHasAlreadyBeenRedeemed < ApiError; end
#  #class CustomerDoesntHaveEnoughPoints < ApiError; end
#  #class EmployeeAlreadyBooked < ApiError; end
#  #class DefaultLengthUndefined < ApiError; end
#  #class UsernameOrPasswordMissing < ApiError; end
#  #class LoginFailed < ApiError; end
#  #class UserTemporarilyBlocked < ApiError; end
#  #class LoginHasNotBeenEnabledForThisUser < ApiError; end
#  #class ApiSessionExpired < ApiError; end
#  #class SessionNotFound < ApiError; end
#  #class NoViewingRights < ApiError; end
#  #class NoAddingRights < ApiError; end
#  #class NoEditingRights < ApiError; end
#  #class NoDeletingRights < ApiError; end
#  #class UserDoesNotHaveAccessToThisWarehouse < ApiError; end
#  #class SalesToThisClientAreBlocked < ApiError; end
#  #class PrintingServiceIsNotRunning < ApiError; end
#  #class EmailSendingFailed < ApiError; end
#  #class EmailSendingIncorrectlySetUp < ApiError; end
#  #class NoFileAttached < ApiError; end
#  #class AttachedFileIsNotEncodedWithBase64 < ApiError; end
#  #class AttachedFileExceedsAllowedSizeLimit < ApiError; end
#  #
#  #ERROR_CODES = YAML::load(File.open(Rails.root + "config/erply_error_codes.yml"))
#
#  #ERRORS = ERROR_CODES.reduce({}) do |result, (k,v)| 
#  #  name = k.camelize
#  #  code = v.to_i
#
#  #  klass = const_get name
#
#  #  result[code] = klass
#  #  result
#  #end
#
#  attr_accessor :body  
#
#  def initialize(typhoeus_response, options={})
#    json  = JSON.parse(typhoeus_response.body)
#    body  = json.deep_symbolize_keys
#
#    #Rails.logger.error("ERPLY: #{body.inspect}")
#
#    @body = body
#
#    raise error.new(self) if returned_error
#  end
#
#  def records
#    body.fetch(:records) { [] }.map(&:deep_symbolize_keys)
#  end
#
#  def failed_authentication?
#    case error_code.to_i 
#    when authentication_error_code.to_i
#      true
#    else
#      false
#    end
#  end
#
#  def error_code
#    status.fetch(:errorCode).to_i 
#  end
#
#  def status
#    body.fetch(:status) 
#  end
#
#  def session_key
#    records[0].fetch(:sessionKey) 
#  end
#
#  def returned_error
#    error_code.present? and error_code != non_error_code
#  end
#
#  def error
#    errors[error_code]
#  end
#
#  private
#
#  def error_codes
#    @@error_codes ||= ERROR_CODES.deep_symbolize_keys
#  end
#
#  def errors
#    @@errors ||= ERRORS
#  end
#
#  def authentication_error_code
#    error_codes[:authentication_parameters_not_found]
#  end
#  
#  def unknown_function_name
#    error_codes[:unknown_function_name]
#  end
#  
#  def non_error_code
#    error_codes[:non_error]
#  end
#
#end
