# tofu-plan-approve-apply

Plan and apply terraforms with one easy step. Enables approvals via thanks to the [trstringer/manual-approval action](https://github.com/trstringer/manual-approval) marketplace addon.

## Usage


### Minimal Usage
```
      - name: Plan and Apply
        uses: jlroskens/tofu-plan-approve-apply@v1
```

### Tfvars Files
```
      - name: Plan and Apply
        uses: jlroskens/tofu-plan-approve-apply@v1
        with:
          var-files: |-
            .env/mysettings1.tfvars
            .env/environment_override.tfvars
```

### Variables
```
      - name: Plan and Apply
        uses: jlroskens/tofu-plan-approve-apply@v1
        with:
          vars: |-
            my_string_var=my_value
            my_map_var={ "my_key": "my_value" }
```

### Approvals
Enabling the `require-approval` requires an issue comment to be approved prior to the `tofu apply` being executed. For details on this process, see the [trstringer/manual-approval action](https://github.com/trstringer/manual-approval) action that this composite action utilizes.

```
      - name: Plan, Approve, Apply
        uses: jlroskens/tofu-plan-approve-apply@v1
        with:
          require-approval: true
          required-approvers: githubuser1, githubuser2
```

### Kitchen Sink
Executes `tofu init`, `plan` and `apply` with `-var-file` and `-var` arguments. Enables arguments for `tofu init`. Requires issue approval between `plan` and `apply` and sets the `working-directory`.

```
      - name: Plan, Approve, Apply
        uses: jlroskens/tofu-plan-approve-apply@v1
        with:
          var-files: |-
            .env/mysettings1.tfvars
            .env/environment_override.tfvars
          vars: |-
            my_string_var=my_value
            my_map_var={ "my_key": "my_value" }
          init-vars-enabled: true
          require-approval: true
          required-approvers: githubuser1, githubuser2
          working-directory: {path_to_manifest}
```