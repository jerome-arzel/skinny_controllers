module SkinnyControllers
  module Lookup
    module Policy
      module_function

      # @param [String] name the name of the model
      # @return [Class] the policy class
      def class_from_model(name)
        policy_class_name = class_name_from_model(name)
        klass = policy_class_name.safe_constantize
        klass || define_policy_class(policy_class_name)
      end

      def class_name_from_model(name)
        parent_namespace = namespace.present? ? "#{namespace}::" : ''
        "#{parent_namespace}#{name}" + SkinnyControllers.policy_suffix
      end

      def define_policy_class(name)
        default_policy = SkinnyControllers::Policy::Default
        Object.const_set(name, default_policy.dup)
      end

      # @param [String] class_name name of the operation class
      def method_name_for_operation(class_name)
        class_name.demodulize.downcase + POLICY_METHOD_SUFFIX
      end

      def namespace
        SkinnyControllers.policies_namespace
      end
    end
  end
end
