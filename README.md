# Form3 Kubernetes Interview

Kubernetes engineers at Form3 build highly available distributed systems on top of Kubernetes across multiple clouds.
Our take home test for Kubernetes engineers is designed to evaluate real world activities that are involved with this role, which in our case would be creating Kubernetes Operators to automate the management of multiple resources within the our Platform.

## Instructions

The goal of this exercise is to build a **Kubernetes Operator** that manages the lifecycle of a Form3 Account. The operator will need to support the creation and deletion of Form3 Accounts. We provided a Fake Form3 Account API in a Docker container which does not require any authorisation nor authentication. You can see how to interact with the Fake Form3 Account API using Go in the section [How to use the official Go Form3 SDK](#how-to-use-the-official-go-form3-sdk). Here is one example of the Account resource that you'll need to implement.

Here is one example on how the Kubernetes Form3 Account resource could look like. 

```yaml
apiVersion: api.form3.tech/v1
kind: Account
metadata:
  name: account-test
spec:
  organisationID: 885afe67-02da-4c11-bc9d-29e844e3ddc6
  id: 115afe67-02da-4c11-bc9d-29e844e3ddc6
  attributes:
    name: ["Samuel"]
    country: "UK"
    baseCurrency: "GBP"
    accountNumber: "41426819"
    accountClassification: "Personal"
    bankID: "400300"
    bankIDCode: "GBDSC"
    bic: "NWBKGB22"
    iban: "GB11NWBK40030041426819"
```

You can design the CRD Specification as you please, this is just an example.

## ⚙️ Tasks

### 1. Build Operator

You'll need to create the Operator using the Go language. You should make use of the available frameworks for Kubernetes operator like [kubebuilder](https://github.com/kubernetes-sigs/kubebuilder) or [operator-sdk](https://sdk.operatorframework.io/).

When building the operator, you can run it *out-of-cluster* against a [Kind](https://kind.sigs.k8s.io/) cluster and using the provided `docker-compose.yaml` to run the Fake Form3 Account API.

Please provide a makefile with common commands.

### 2. Implement Integration Tests

You should implement quality integration tests to ensure that the Operator works correctly across the Account lifecycle.

You can implement them using the *out-of-cluster* strategy against a Kind cluster or even using the [envtest](https://book.kubebuilder.io/reference/envtest.html) package that comes with kubebuilder.

The tests should run successfully by running `make test`.

### 3. Deploy solution on a Kubernetes Cluster

As a final step we would like to deploy the whole solution in a Kind cluster.

- You should convert the docker-compose manifest into Kubernetes manifests and deploy them to the cluster
- You should install the operator in the Kind cluster
- Use `kind load docker-image` command to have the Operator docker image available in-cluster


### 4. Document you design decisions

- Add a README detailing your design decisions, and please leave a note if you never created a Kubernetes Operator :)

### How to use the official Go Form3 SDK

Import the Form3 Go SDK into the project

```bash
go get github.com/form3tech-oss/go-form3/v3
```

Create a Form3 Client and invoke the creation of an account resource

```go
import(
    "github.com/form3tech-oss/go-form3/v3/pkg/form3"
    "github.com/form3tech-oss/go-form3/v3/pkg/generated/models"
)

func main(){
	u, err := url.Parse(form3ApiURL)
	if err != nil {
		log.Fatal(err)
	}

	f3, err := form3.New(form3.WithBaseURL(*u))
	if err != nil {
		log.Fatal(err)
	}

  account := &models.Account{
		Attributes: &models.AccountAttributes{
            ...
		},
		OrganisationID: "organisation",
		Type:           "accounts",
	}

  acc, err := r.F3.Accounts.
    GetAccount().
    WithContext(ctx).
    WithID(strfmt.UUID(account.Spec.ID)).
    Do()

  if err != nil {
		log.Fatal(err)
	}
}

```

## Using an M1 Mac?
If you are using an M1 Mac then you need to install some additional tools:
- [Multipass](https://github.com/canonical/multipass/releases) install the latest release for your operating system
- [Multipass provider for vagrant](https://github.com/Fred78290/vagrant-multipass)
    - [Install the plugin](https://github.com/Fred78290/vagrant-multipass#plugin-installation)
    - [Create the multipass vagrant box](https://github.com/Fred78290/vagrant-multipass#create-multipass-fake-box)

## 📝 Candidate instructions
1. Create a private [GitHub](https://help.github.com/en/articles/create-a-repo) repository
2. Copying all files from this repository into your new private repository
3. Complete the [Task](#task) :tada:
4. [Invite](https://help.github.com/en/articles/inviting-collaborators-to-a-personal-repository) [@form3tech-interviewer-1](https://github.com/form3tech-interviewer-1) to your private repo
5. Let us know you've completed the exercise using the link provided at the bottom of the email from our recruitment team

## License

Copyright 2019-2022 Form3 Financial Cloud

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.